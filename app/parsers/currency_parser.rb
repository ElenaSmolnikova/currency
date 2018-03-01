class CurrencyParser
  attr_accessor :rates
  def initialize(response)
    @rates = response.fetch('payload', {}).fetch('rates', {}) 
  end

  def rub_deposit_payments
    rub_deposit_payments = deposit_payments.select { |dp| dp.fetch('toCurrency', {}).fetch('name') == 'RUB' }
    {
      usd_sell: get_value('USD', 'sell', rub_deposit_payments),
      usd_buy: get_value('USD', 'buy', rub_deposit_payments),
      eur_sell: get_value('EUR', 'sell', rub_deposit_payments),
      eur_buy: get_value('EUR', 'buy', rub_deposit_payments)
    }
  end

  def deposit_payments
    rates.select {|rate| rate['category'] == 'DepositPayments'}
  end

  def get_value(currency, op, rates)
    rates
      .select {|rate| rate.fetch('fromCurrency', {})['name'] == currency}
      .first
      .try(:[], op)
  end
end
