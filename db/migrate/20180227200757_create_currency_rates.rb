class CreateCurrencyRates < ActiveRecord::Migration[5.0]
  def change
    create_table :currency_rates do |t|
    	t.timestamp :updated_at
    	t.float :usd_sell
    	t.float :usd_buy
    	t.float :eur_sell
    	t.float :eur_buy
    end
  end
end
