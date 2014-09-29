class FriendSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :twitter, :total_articles

  embed :ids

  has_many :articles, include: true

  def total_articles
    object.articles.count
  end
end
