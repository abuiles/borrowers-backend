class FriendSideloadSerializer < FriendSerializer
  embed :ids

  has_many :articles, include: true
end
