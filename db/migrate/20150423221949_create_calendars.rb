class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :embed_url
      t.integer :organization_id

      t.timestamps
    end
  end
end
