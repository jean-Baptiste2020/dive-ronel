require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  scenario 'User information is correct' do
    User.create(
      name: 'test',
      email: 'test@test.com',
      password: '123456'
    )

    visit new_user_session_path
    page.fill_in 'user_email', with: 'test@test.com'
    page.fill_in 'user_password', with: '123456'
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end
