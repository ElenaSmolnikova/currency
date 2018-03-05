class CurrencyRatesController < ApplicationController

  def index
    currencies = CurrencyRate.order(:updated_at)
    @chart = helpers.highchart(currencies)
  end
end
