class CurrencyApi
  URL = 'https://www.tinkoff.ru/api/v1/currency_rates/'
  def self.get_rate
    response = JSON.parse(RestClient.get(URL).body)
    CurrencyParser.new(response).rub_deposit_payments
  end
end
