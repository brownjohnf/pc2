require 'test_helper'

class RegiontypesControllerTest < ActionController::TestCase
  setup do
    @regiontype = regiontypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regiontypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regiontype" do
    assert_difference('Regiontype.count') do
      post :create, regiontype: @regiontype.attributes
    end

    assert_redirected_to regiontype_path(assigns(:regiontype))
  end

  test "should show regiontype" do
    get :show, id: @regiontype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regiontype.to_param
    assert_response :success
  end

  test "should update regiontype" do
    put :update, id: @regiontype.to_param, regiontype: @regiontype.attributes
    assert_redirected_to regiontype_path(assigns(:regiontype))
  end

  test "should destroy regiontype" do
    assert_difference('Regiontype.count', -1) do
      delete :destroy, id: @regiontype.to_param
    end

    assert_redirected_to regiontypes_path
  end
end
