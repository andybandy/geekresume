class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :title
      t.text :key
      t.integer :user_id

      t.timestamps
    end
  end
end
