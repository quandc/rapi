class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :token
      t.string :content
      t.string :category
      t.timestamps null: false
    end

  end
end
