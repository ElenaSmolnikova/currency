class CurrencyRatesController < ApplicationController
  def index
    currencies = CurrencyRate.order(:updated_at)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Today Currency Rate")
      f.subtitle(text: "Average
        USD sell: #{CurrencyRate.usd_sell_average}
        USD buy: #{CurrencyRate.usd_buy_average}
        EUR sell: #{CurrencyRate.eur_sell_average}
        EUR buy: #{CurrencyRate.eur_buy_average}")
      f.xAxis(categories: currencies.pluck(:updated_at).map{|d| d.strftime('%I:%M %p')})
      f.series(name: "USD sell", yAxis: 0, data: currencies.pluck(:usd_sell).to_a)
      f.series(name: "EUR sell", yAxis: 1, data: currencies.pluck(:eur_sell).to_a)
      f.series(name: "USD buy", yAxis: 2, data: currencies.pluck(:usd_buy).to_a)
      f.series(name: "EUR buy", yAxis: 3, data: currencies.pluck(:eur_buy).to_a)

      f.yAxis [
        {title: {text: "USD sell"}},
        {title: {text: "EUR sell"}, opposite: true },
        {title: {text: "USD buy"}},
        {title: {text: "EUR buy"}, opposite: true },
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "spline"})
    end
  end
end
