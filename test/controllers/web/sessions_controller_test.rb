# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should destroy session' do
    sign_in users(:one)
    assert signed_in?

    post sign_out_url
    assert !signed_in?
    assert_response :redirect
  end
end
