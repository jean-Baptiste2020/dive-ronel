require 'rails_helper'

RSpec.describe User do
  user = User.create(
    name: 'test',
    email: 'test@test.com',
    password: 123_456
  )

  it 'validates user name presence' do
    user = User.new
    user.save
    expect(user).to be_invalid
  end

  it 'validates user name length max 20' do
    user = User.new(name: 'a' * 21)
    user.save
    expect(user).to be_invalid
  end

  it 'should have many friendships' do
    t = User.reflect_on_association(:friendships)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many inverse friendships' do
    t = User.reflect_on_association(:inverse_friendships)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many friends' do
    t = User.reflect_on_association(:friends)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many pending friends' do
    t = User.reflect_on_association(:pending_friends)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many post' do
    t = User.reflect_on_association(:posts)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many comments' do
    t = User.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many likes' do
    t = User.reflect_on_association(:likes)
    expect(t.macro).to eq(:has_many)
  end

  describe 'Friend request method' do
    it 'Retreives all friendships that are not confirmed yet' do
      expect(user.friend_requests).to eq([])
    end
  end

  describe 'Friends method' do
    it 'Retrieves all friendships that are not confirmed yet' do
      friends = user.friends
      expect(friends).to eq([])
    end
  end
end

