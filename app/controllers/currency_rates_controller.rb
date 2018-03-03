class CurrencyRatesController < ApplicationController
  def index
    currencies = CurrencyRate.order(:updated_at)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Currency Rate")
      f.subtitle(text: "Average
        USD sell: #{CurrencyRate.usd_sell_average}
        USD buy: #{CurrencyRate.usd_buy_average}
        EUR sell: #{CurrencyRate.eur_sell_average}
        EUR buy: #{CurrencyRate.eur_buy_average}")
      f.xAxis(categories: currencies.pluck(:updated_at).to_a, type: 'datetime')
      f.series(name: "USD sell", yAxis: 0, data: currencies.pluck(:usd_sell).to_a)
      f.series(name: "EUR sell", yAxis: 1, data: currencies.pluck(:eur_sell).to_a)
      f.series(name: "USD buy", yAxis: 2, data: currencies.pluck(:usd_buy).to_a)
      f.series(name: "EUR buy", yAxis: 3, data: currencies.pluck(:eur_buy).to_a)

      f.yAxis [
        {floor: 0, title: {text: "USD sell", margin: 70}, ceiling: 100 },
        {floor: 0, title: {text: "EUR sell"}, opposite: true, ceiling: 100 },
        {floor: 0, title: {text: "USD buy", margin: 70}, ceiling: 100 },
        {floor: 0, title: {text: "EUR buy"}, opposite: true, ceiling: 100 },
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "spline"})
    end
  end
end
