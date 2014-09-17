class FriendSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :twitter, :total_articles

  def total_articles
    object.articles.count
  end
end
