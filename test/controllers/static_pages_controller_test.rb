require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get whyus" do
    get :whyus
    assert_response :success
  end

  test "should get aboutus" do
    get :aboutus
    assert_response :success
  end

  test "should get profiler" do
    get :profiler
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
