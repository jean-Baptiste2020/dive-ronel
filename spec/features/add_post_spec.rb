require 'rails_helper'

RSpec.feature 'AddPost', type: :feature do
  scenario 'A logged in user can post a post' do
    User.create(
      name: 'John',
      email: 'john@example.com',
      password: 'password'
    )
    visit new_user_session_path
    page.fill_in 'user_email', with: 'john@example.com'
    page.fill_in 'user_password', with: 'password'
    click_on(class: 'login')
    page.fill_in 'post_content', with: 'This is a post'
    click_on 'Save'
    have_content 'This is a post'
  end
end

