class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :token
      t.string :user
      t.string :content
      t.string :category
      t.timestamps null: false
    end

    add_index :messages, :user
  end
end
