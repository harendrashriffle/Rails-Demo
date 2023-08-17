class CreateUserProfilePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profile_pictures do |t|
      t.boolean :profile_picture
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
