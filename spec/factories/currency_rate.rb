FactoryBot.define do
  sequence :i do |i|
    i
  end
  factory :currency_rate do |f|
    usd_buy 50
    usd_sell 55
    eur_buy 60
    eur_sell 65
  end
end
