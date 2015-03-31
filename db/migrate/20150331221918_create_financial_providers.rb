class CreateFinancialProviders < ActiveRecord::Migration
  def change
    create_table :financial_providers do |t|
      t.string :name
      t.string :external_url

      t.timestamps
    end
  end
end
