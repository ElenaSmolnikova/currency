require 'rails_helper'

RSpec.describe CurrencyApi do
  before do
    allow(RestClient)
      .to receive(:get)
      .with(CurrencyApi::URL)
      .and_return(
        OpenStruct.new(
          body: File.read('spec/fixtures/tinkoff_response_body.txt')
        )
      )
  end

  let(:right_result_hash) {
    {
      usd_sell: 58.3,
      usd_buy: 56.0,
      eur_sell: 71.8,
      eur_buy: 69.0
    }
  }

  it "parsers response to hash" do
    expect(described_class.get_rate)
    .to eq(right_result_hash)
  end

  let(:api_response_in_json){
    {"payload":
      {"rates":[
        {"category":"DepositPayments",
        "fromCurrency":{"name":"USD","code":840},
        "toCurrency":{"name":"RUB","code":643},
        "buy":56.0,
        "sell":58.3},
        {"category":"DepositPayments",
        "fromCurrency":{"name":"EUR","code":978},
        "toCurrency":{"name":"RUB","code":643},
        "buy":69.0,
        "sell":71.8}]
      }
    }
  }

  it "parsers response to hash" do
    stub = double()
    expect(CurrencyParser)
      .to receive(:new)
      .with(api_response_in_json.deep_stringify_keys)
      .and_return(stub)
    expect(stub)
      .to receive(:rub_deposit_payments)
      .and_return(right_result_hash)
    described_class.get_rate
  end
end
