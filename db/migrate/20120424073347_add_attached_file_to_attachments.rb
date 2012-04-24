class AddAttachedFileToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :attached_file, :string

  end
end
