class CreateBookUsers < ActiveRecord::Migration
  def change
    create_table :book_users do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :vote, default: 0
      t.boolean :purchased, default: false
      t.boolean :read, default: false
      t.integer :star_rating
      t.string :bucket

      t.timestamps
    end
  end
end
