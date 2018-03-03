FactoryBot.define do
  sequence :i do |i|
    i
  end
  factory :currency_rate do |f|
    f.sequence(:usd_buy)  { |i| 50 + i*0.2 }
    f.sequence(:usd_sell) { |i| 55 + i*0.2 }
    f.sequence(:eur_buy)  { |i| 60 + i*0.2 }
    f.sequence(:eur_sell) { |i| 65 + i*0.2 }
  end
end
