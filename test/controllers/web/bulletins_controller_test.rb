# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @bulletin.image.attach(io: Rails.root.join('test/fixtures/files/food_1.jpg').open, filename: 'filename.jpg')
    @another_user_bulletin = bulletins(:four)
    @another_user_bulletin.image.attach(io: Rails.root.join('test/fixtures/files/food_1.jpg').open, filename: 'filename.jpg')
    @user = users(:one)
    @category = categories(:one)
    image_path = Rails.root.join('test/fixtures/files/food_1.jpg')
    @image = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')
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

  test 'should show unpublished bulletin to admin' do
    sign_in users(:admin)
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    sign_in @user
    title = Faker::Lorem.sentence(word_count: 3)
    description = Faker::Lorem.paragraph
    category_id = @category.id
    post bulletins_url,
         params: {
           bulletin: {
             title:,
             description:,
             category_id:,
             image: @image
           }
         }
    assert Bulletin.find_by(title:)
  end

  test 'should get edit' do
    sign_in @user
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    sign_in @user
    title = Faker::Lorem.sentence(word_count: 3)
    description = @bulletin.description
    category_id = @bulletin.category_id
    user_id = @bulletin.user_id
    patch bulletin_url(@bulletin),
          params: {
            bulletin: {
              title:,
              description:,
              category_id:,
              user_id:,
              image: @image
            }
          }
    assert Bulletin.find_by(title:)
  end

  test 'should archive bulletin' do
    sign_in @user
    bulletin = bulletins(:three)
    bulletin.image.attach(io: Rails.root.join('test/fixtures/files/food_1.jpg').open, filename: 'filename.jpg')
    patch archive_bulletin_url(bulletin)
    assert_redirected_to profile_path
    assert bulletin.reload.archived?
  end

  test 'should not archive another user bulletin' do
    sign_in(@user)
    patch archive_bulletin_url(@another_user_bulletin)
    assert_redirected_to root_url
    assert @another_user_bulletin.reload.draft?
  end

  test 'should moderate bulletin' do
    sign_in @user
    patch moderate_bulletin_url(@bulletin)
    assert_redirected_to profile_path
    assert @bulletin.reload.under_moderation?
  end

  test 'should not moderate another user bulletin' do
    sign_in(@user)
    patch moderate_bulletin_url(@another_user_bulletin)
    assert_redirected_to root_url
    assert @another_user_bulletin.reload.draft?
  end
end
