module RateUpdater
  def self.perform
    updated_at = DateTime.now.beginning_of_hour
      api_rate = CurrencyApi.get_rate
      currency_rate = CurrencyRate.where(updated_at: updated_at - 1.day).first_or_create!
      currency_rate.update_attributes!(
        updated_at: updated_at,
        usd_sell: api_rate[:usd_sell],
        usd_buy: api_rate[:usd_buy],
        eur_sell: api_rate[:eur_sell],
        eur_buy: api_rate[:eur_buy]
      )
  end
end
