# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)
    @category_attributes = { name: Faker::Lorem.paragraph_by_chars(number: 50) }
    @category = categories(:one)
    @category_without_bulletins = categories(:three)
  end

  test 'should get index' do
    sign_in @admin
    get admin_categories_url
    assert_response :success
  end

  test 'should not get index without login' do
    get admin_categories_url
    assert_redirected_to root_url
  end

  test 'should not get index if not an admin' do
    sign_in @user
    get admin_categories_url
    assert_redirected_to root_url
  end

  test 'should get new' do
    sign_in @admin
    get new_admin_category_url
    assert_response :success
  end

  test 'should get create' do
    sign_in @admin
    post admin_categories_url, params: { category: @category_attributes }
    category = Category.find_by(@category_attributes)

    assert category
    assert_redirected_to admin_categories_url
  end

  test 'should get edit' do
    sign_in @admin
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should update category' do
    sign_in @admin
    patch admin_category_url(@category), params: { category: @category_attributes }
    @category.reload

    assert @category.name == @category_attributes[:name]
    assert_redirected_to admin_categories_url
  end

  test 'should not update category if not an admin' do
    sign_in @user
    patch admin_category_url(@category), params: { category: @category_attributes }
    @category.reload

    assert @category.name != @category_attributes[:name]
    assert_redirected_to root_url
  end

  test 'should not update category without login' do
    patch admin_category_url(@category), params: { category: @category_attributes }
    @category.reload

    assert @category.name != @category_attributes[:name]
    assert_redirected_to root_url
  end

  test 'should destroy category' do
    sign_in @admin
    delete admin_category_url(@category_without_bulletins)

    assert_redirected_to admin_categories_url
    assert Category.exists?
    assert_nil Category.find_by(id: @category_without_bulletins.id)
  end

  test 'should not destroy category with bulletins' do
    sign_in @admin
    delete admin_category_url(@category)

    assert_redirected_to admin_categories_url
    assert Category.exists? @category.id
  end
end
