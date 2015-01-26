class AddTotalArticlesToFriends < ActiveRecord::Migration

  def self.up

    add_column :friends, :total_articles, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :friends, :total_articles

  end

end
