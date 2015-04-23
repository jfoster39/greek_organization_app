class AddTypeToDocuments < ActiveRecord::Migration
  def change
      add_column :documents, :type, :text
  end
end
