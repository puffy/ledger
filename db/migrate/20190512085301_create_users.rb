class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.decimal :balance, default: 0, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
