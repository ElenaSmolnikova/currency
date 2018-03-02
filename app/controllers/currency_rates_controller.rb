class CurrencyRatesController < ApplicationController
  def index
    @currencies = CurrencyRate.order(:updated_at)
    @average_values = CurrencyRate.average_values
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(text: "Currency Rate")
		  f.xAxis(categories: @currencies.pluck(:updated_at).to_a)
		  f.series(name: "USD sell", yAxis: 0, data: @currencies.pluck(:usd_sell).to_a)
		  f.series(name: "EUR sell", yAxis: 1, data: @currencies.pluck(:eur_sell).to_a)

		  f.yAxis [
		    {title: {text: "USD sell", margin: 70} },
		    {title: {text: "EUR sell"}, opposite: true},
		  ]

		  f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
		  f.chart({defaultSeriesType: "column"})
		end
  end
end
