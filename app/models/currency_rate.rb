class CurrencyRate < ApplicationRecord
	def self.average_values
		currency_rates = CurrencyRate.all
		{
			usd_sell: currency_rates.sum(:usd_sell)/currency_rates.length,
			usd_buy: currency_rates.sum(:usd_buy)/currency_rates.length,
			eur_sell: currency_rates.sum(:eur_sell)/currency_rates.length,
			eur_buy: currency_rates.sum(:eur_buy)/currency_rates.length
		}
	end
end
