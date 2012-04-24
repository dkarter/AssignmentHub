class AddDescriptionToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :attachment_description, :string

  end
end
