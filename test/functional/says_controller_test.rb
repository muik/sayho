require 'test_helper'

class SaysControllerTest < ActionController::TestCase
  setup do
    @say = says(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:says)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create say" do
    assert_difference('Say.count') do
      post :create, say: { nickname: @say.nickname, text: @say.text }
    end

    assert_redirected_to say_path(assigns(:say))
  end

  test "should show say" do
    get :show, id: @say
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @say
    assert_response :success
  end

  test "should update say" do
    put :update, id: @say, say: { nickname: @say.nickname, text: @say.text }
    assert_redirected_to say_path(assigns(:say))
  end

  test "should destroy say" do
    assert_difference('Say.count', -1) do
      delete :destroy, id: @say
    end

    assert_redirected_to says_path
  end
end
