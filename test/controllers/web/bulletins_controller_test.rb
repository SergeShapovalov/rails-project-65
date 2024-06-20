require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should show bulletin' do
    get bulletin_url(bulletins(:two))
    assert_response :success
  end

  test 'should not show unpublished bulletin' do
    get bulletin_url(@bulletin)
    assert_redirected_to root_url
  end

  test 'should show unpublished bulletin to owner' do
    sign_in @user
    get bulletin_url(@bulletin)
    assert_response :success
  end
end
