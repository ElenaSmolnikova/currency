module RateUpdater
  def self.perform
    updated_at = DateTime.now.beginning_of_hour
      rate = CurrencyApi.get_rate
      CurrencyRate.where(updated_at: updated_at - 1.day).first_or_create!(
        updated_at: updated_at,
        usd_sell: rate[:usd_sell],
        usd_buy: rate[:usd_buy],
        eur_sell: rate[:eur_sell],
        eur_buy: rate[:eur_buy]
      )
  end
end
