class AddNotesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :notes, :text, default: ''
  end
end
