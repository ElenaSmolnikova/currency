class CurrencyRatesController < ApplicationController
	def index
		@currencies = CurrencyRate.order(:updated_at)
		@average_values = CurrencyRate.average_values
	end
end
