class CurrencyRate < ApplicationRecord
  class << self
    [:usd_sell, :usd_buy, :eur_sell, :eur_buy].each do |operation|
      define_method :"#{operation}_average" do
        (all.sum(operation)/count).round(2)
      end
    end
  end
end
