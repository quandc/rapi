class RemoveTokenFromMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :token, :string
  end
end
