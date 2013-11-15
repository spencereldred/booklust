class CreateBookUsers < ActiveRecord::Migration
  def change
    create_table :book_users do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :vote
      t.boolean :purchased
      t.boolean :read
      t.integer :star_rating
      t.string :bucket

      t.timestamps
    end
  end
end
