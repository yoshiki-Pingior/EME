require 'test_helper'

class RailsControllerTest < ActionDispatch::IntegrationTest
  test "should get g" do
    get rails_g_url
    assert_response :success
  end

  test "should get devise:install" do
    get rails_devise:install_url
    assert_response :success
  end

end
