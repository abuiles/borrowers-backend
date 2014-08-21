class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :description
      t.string :state, default: :borrowed
      t.references :friend

      t.timestamps
    end
  end
end
