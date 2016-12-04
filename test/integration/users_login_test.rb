require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user_one)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    # send bad params
    post login_path, params: { session: { email: '', password: '' } }
    #check that the user is redirected to the login page
    assert_template 'sessions/new'
    # check that the flash appears
    assert_not flash.empty?
    # navigate to another page
    get root_path
    # check that the flash does not appear
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'test_user_password' } }

    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end


end
