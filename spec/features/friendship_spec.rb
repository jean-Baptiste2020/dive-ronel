require 'rails_helper'

RSpec.feature 'AddFriend' do
  scenario 'Succesfully logs in/out' do
    john = User.create(name: 'John',
                       email: 'john@example.com',
                       password: 'password')
    matt = User.create(name: 'Matt',
                       email: 'matt@example.com',
                       password: 'password')
    count = Friendship.count
    Friendship.create(user_id: matt.id, friend_id: john.id, confirmed: false)
    visit new_user_session_path
    page.fill_in 'user_email', with: 'john@example.com'
    page.fill_in 'user_password', with: 'password'
    click_on(class: 'login')
    expect(page).to have_content('Signed in successfully.')
    click_on 'Friends'
    expect(page).not_to have_content('No new friend requests...')
    click_on 'Accept'
    count2 = Friendship.count
    expect(count).not_to eq(count2)
  end
end

