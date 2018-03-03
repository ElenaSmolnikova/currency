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
  end
  let(:usd_buy_aver)  {50.5}
  let(:usd_sell_aver) {55.5}
  let(:eur_buy_aver)  {60.5}
  let(:eur_sell_aver) {65.5}

  [:usd_sell, :usd_buy, :eur_sell, :eur_buy].each do |operation|
    it_behaves_like 'method presents' do
      let(:operation) { operation }
    end

    it "counts #{operation}_average value" do
      expect(CurrencyRate.send("#{operation}_average")).to eq(send("#{operation}_aver"))
    end
  end
end
