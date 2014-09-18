class ChangeColumnUserIdInArticles < ActiveRecord::Migration
  def change
    change_column :articles, :friend_id, :string, null: false
  end
end
