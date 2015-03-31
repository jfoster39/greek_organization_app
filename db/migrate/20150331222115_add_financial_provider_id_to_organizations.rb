class AddFinancialProviderIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :financial_provider_id, :integer
  end
end
