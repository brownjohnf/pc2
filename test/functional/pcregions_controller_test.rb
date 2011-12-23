require 'test_helper'

class PcregionsControllerTest < ActionController::TestCase
  setup do
    @pcregion = pcregions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pcregions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pcregion" do
    assert_difference('Pcregion.count') do
      post :create, pcregion: @pcregion.attributes
    end

    assert_redirected_to pcregion_path(assigns(:pcregion))
  end

  test "should show pcregion" do
    get :show, id: @pcregion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pcregion.to_param
    assert_response :success
  end

  test "should update pcregion" do
    put :update, id: @pcregion.to_param, pcregion: @pcregion.attributes
    assert_redirected_to pcregion_path(assigns(:pcregion))
  end

  test "should destroy pcregion" do
    assert_difference('Pcregion.count', -1) do
      delete :destroy, id: @pcregion.to_param
    end

    assert_redirected_to pcregions_path
  end
end
