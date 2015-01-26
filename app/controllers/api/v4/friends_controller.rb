class Api::V4::FriendsController < Api::FriendsController
  def index
    @friends = FriendsIndexQuery.find(Friend.all, params)

    render json: @friends, each_serializer: FriendV4Serializer
  end


  def show
    render json: @friend, serializer: FriendV4Serializer, root: :friend
  end
end
