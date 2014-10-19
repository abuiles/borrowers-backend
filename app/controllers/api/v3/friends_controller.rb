class Api::V3::FriendsController < Api::FriendsController
  def index
    @friends = Friend.all

    render json: @friends, each_serializer: FriendV3Serializer
  end


  def show
    render json: @friend, serializer: FriendV3Serializer, root: :friend
  end
end
