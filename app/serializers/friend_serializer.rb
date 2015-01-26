class FriendSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :twitter, :total_articles
end
