require 'test_helper'

class OpenPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get open_pages_index_url
    assert_response :success
  end

end
