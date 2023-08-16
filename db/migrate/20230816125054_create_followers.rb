class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.string :username
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
