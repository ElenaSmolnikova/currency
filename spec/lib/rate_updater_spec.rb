require 'rails_helper'

RSpec.describe RateUpdater do
  let(:currency_api_response){
    {
      usd_sell: 59.3,
      usd_buy: 57.0,
      eur_sell: 72.8,
      eur_buy: 70.0
    }
  }

  let!(:rate_id){
    create(:currency_rate, updated_at: Date.parse('2018-01-01').midday).id
  }
  let!(:another_rate){
    create(:currency_rate, updated_at: DateTime.parse('2018-01-01 13:00:00'))
  }

  before do
    allow(CurrencyApi).to receive(:get_rate).and_return(currency_api_response)
    allow(DateTime).to receive(:now).and_return(Date.parse('2018-01-02').midday)
  end
  it 'updates yesterday_midday_rate' do
    described_class.perform
    expect(CurrencyRate.find(rate_id).attributes)
      .to eq(
        currency_api_response
          .merge!(
            updated_at: DateTime.now,
            id: rate_id
          )
          .stringify_keys
      )
  end
end
