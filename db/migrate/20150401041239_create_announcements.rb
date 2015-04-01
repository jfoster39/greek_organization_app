class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.integer :user_id
      t.integer :organization_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
