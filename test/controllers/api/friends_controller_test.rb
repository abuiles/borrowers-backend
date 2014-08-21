require 'test_helper'

class Api::FriendsControllerTest < ActionController::TestCase
  setup do
    @friend = friends(:one)
  end

  test "gets index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friends)
  end

  test "creates friend" do
    assert_difference('Friend.count') do
      post :create, friend: {
        first_name: 'Arya',
        last_name: 'Stark',
        twitter: 'arya',
        email: 'arya@winterfell.com'
      }
    end

    assert_response 201
  end

  test "shows friend" do
    get :show, id: @friend
    assert_response :success
  end

  test "updates friend" do
    put :update, id: @friend, friend: { first_name: 'Edward' }
    assert_response 204
  end

  test "destroys friend" do
    assert_difference('Friend.count', -1) do
      delete :destroy, id: @friend
    end

    assert_response 204
  end
end
