class Api::V2::FriendsController < Api::FriendsController
  def index
    @friends = FriendsIndexQuery.find(Friend.all, params)

    render json: @friends, each_serializer: FriendV2Serializer
  end


  # GET /friends/1.json
  def show
    render json: @friend, serializer: FriendV2Serializer, root: :friend
  end
end
