class Api::FriendsController < ApplicationController
  before_filter :set_friend, only: [:show, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    @friends = Friend.all

    render json: @friends, each_serializer: serializer
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    render json: @friend
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)

    if @friend.save
      render json: @friend, status: :created, location: [:api, @friend]
    else
      render json: { errors: @friend.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    if @friend.update(friend_params)
      head :no_content
    else
      render json: { errors: @friend.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy

    head :no_content
  end

  private

  def set_friend
    @friend = Friend.find(params[:id])
  end

  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :twitter, :email)
  end

  def serializer
    case params[:serializer]
    when 'sideload'
      FriendSideloadSerializer
    else
      FriendSerializer
    end
  end
end
