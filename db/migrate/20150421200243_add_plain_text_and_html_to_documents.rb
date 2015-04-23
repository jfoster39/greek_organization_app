class AddPlainTextAndHtmlToDocuments < ActiveRecord::Migration
    def change
        add_column :documents, :plaintext_body, :text
        add_column :documents, :html_body, :text
        remove_column :documents, :body, :text
    end
end
