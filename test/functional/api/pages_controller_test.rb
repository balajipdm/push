require 'test_helper'

class Api::PagesControllerTest < ActionController::TestCase

  setup do
    @page = pages(:one)
  end

  def test_should_get_index
    get :index
    assert_response :success
	assert_not_nil assigns(:pages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_page
    assert_difference('Page.count') do
      post :create, page: { :title => 'test page title', :content => 'test page content' }
    end
    assert_response :success
  end

  def test_should_fail_to_create_page
    assert_no_difference('Page.count') do
      post :create, page: { :title => nil }
    end
    assert_response :success
  end

  def test_should_get_edit_page
    get :edit, id: @page.to_param
    assert_response :success
  end

  def test_should_update_page
    put :update, id: @page.to_param, page: @page.attributes
    assert_response :success
  end

  def test_should_fail_to_update_page
    put :update, id: @page.to_param, page: { :title => nil }
    assert_response :success
  end

  def test_should_destroy_page
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page.to_param
    end
    assert_response :success
  end

end
