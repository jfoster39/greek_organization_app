class AddLinkToDocuments < ActiveRecord::Migration
    def change
        add_column :documents, :link, :text
        remove_column :documents, :html_body, :text
        remove_column :documents, :plaintext_body, :text
    end
end
