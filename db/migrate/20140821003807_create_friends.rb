class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :first_name
      t.string :last_name
      t.string :twitter
      t.string :email

      t.timestamps
    end
  end
end
