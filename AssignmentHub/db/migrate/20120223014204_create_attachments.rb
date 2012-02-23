class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :type
      t.string :upload_date
      t.string :server_path

      t.timestamps
    end
  end
end
