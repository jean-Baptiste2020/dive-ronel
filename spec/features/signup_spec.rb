require 'rails_helper'

RSpec.feature 'Signup', type: :feature do
  scenario 'A new user creates a new account' do
    visit new_user_registration_path
    fill_in 'name', with: 'test'
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: '123456'
    fill_in 'password_confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
