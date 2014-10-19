class FriendV4Serializer < FriendSerializer
  attributes :links

  def links
    {
      articles: api_v4_articles_path(friend_id: object.id)
    }
  end
end
