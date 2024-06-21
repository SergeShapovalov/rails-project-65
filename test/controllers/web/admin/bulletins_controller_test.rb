# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:five)
    @bulletin.image.attach(io: Rails.root.join('test/fixtures/files/food_1.jpg').open, filename: 'filename.jpg')
    @admin = users(:admin)
    @user = users(:one)
  end

  test 'should get index' do
    sign_in @admin
    get admin_bulletins_url
    assert_response :success
  end

  test 'should reject bulletin' do
    sign_in @admin
    patch reject_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_url
    assert @bulletin.reload.rejected?
  end

  test 'should not reject bulletin if not an admin' do
    sign_in @user
    patch reject_admin_bulletin_url(@bulletin)

    assert_redirected_to root_url
    assert @bulletin.reload.under_moderation?
  end

  test 'should not reject bulletin without login' do
    patch reject_admin_bulletin_url(@bulletin)

    assert_redirected_to root_url
    assert @bulletin.reload.under_moderation?
  end

  test 'should archive bulletin' do
    sign_in @admin
    patch archive_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_bulletins_path
    assert @bulletin.reload.archived?
  end

  test 'should publish bulletin' do
    sign_in @admin
    patch publish_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_url
    assert @bulletin.reload.published?
  end
end
