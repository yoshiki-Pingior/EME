require 'test_helper'

class FindersControllerTest < ActionDispatch::IntegrationTest
  test "should get finder" do
    get finders_finder_url
    assert_response :success
  end

end
