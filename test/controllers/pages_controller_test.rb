require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get how_it_works" do
    get :how_it_works
    assert_response :success
  end

end
