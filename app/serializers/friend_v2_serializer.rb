class FriendV2Serializer < FriendSerializer
  embed :ids

  has_many :articles, include: true
end
