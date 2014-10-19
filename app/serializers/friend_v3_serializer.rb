class FriendV3Serializer < FriendSerializer
  embed :ids

  has_many :articles
end
