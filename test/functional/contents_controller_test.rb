require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get init" do
    get :init
    assert_response :success
  end

  test "should get roll" do
    get :roll
    assert_response :success
  end

end
