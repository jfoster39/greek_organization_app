class AddPlainTextAndHtmlToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :plaintext_body, :text
    add_column :announcements, :html_body, :text
    remove_column :announcements, :body, :text
  end
end
