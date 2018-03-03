require 'rails_helper'

RSpec.shared_examples 'method presents' do
  it "doesn't raise NoMethodError" do
    expect{ CurrencyRate.send("#{operation}_average") }.not_to raise_error
  end
end

RSpec.describe CurrencyRate do
  before(:all) do
    4.times do |i|
      create(:currency_rate)
    end
    CurrencyRate.limit(2).each do |r|
      r.update(
        usd_buy: 52,
        usd_sell: 57,
        eur_buy: 62,
        eur_sell: 67
      )
    end
  end
  let(:usd_buy_aver)  {51}
  let(:usd_sell_aver) {56}
  let(:eur_buy_aver)  {61}
  let(:eur_sell_aver) {66}

  [:usd_sell, :usd_buy, :eur_sell, :eur_buy].each do |operation|
    it_behaves_like 'method presents' do
      let(:operation) { operation }
    end

    it "counts #{operation}_average value" do
      expect(CurrencyRate.send("#{operation}_average")).to eq(send("#{operation}_aver"))
    end
  end
end
