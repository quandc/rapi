class AddMailTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :client_id, :string
  end
end
