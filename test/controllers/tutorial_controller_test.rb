require 'test_helper'

class TutorialControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get tutorial_top_url
    assert_response :success
  end

end
