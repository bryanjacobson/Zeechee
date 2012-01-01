require 'test_helper'

class ItemTypesControllerTest < ActionController::TestCase
  setup do
    @item_type = item_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_type" do
    assert_difference('ItemType.count') do
      post :create, :item_type => @item_type.attributes
    end

    assert_redirected_to item_type_path(assigns(:item_type))
  end

  test "should show item_type" do
    get :show, :id => @item_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @item_type.to_param
    assert_response :success
  end

  test "should update item_type" do
    put :update, :id => @item_type.to_param, :item_type => @item_type.attributes
    assert_redirected_to item_type_path(assigns(:item_type))
  end

  test "should destroy item_type" do
    assert_difference('ItemType.count', -1) do
      delete :destroy, :id => @item_type.to_param
    end

    assert_redirected_to item_types_path
  end
end
