require 'rails_helper'

RSpec.describe Comment do
  it 'validates post and user presence' do
    comment = Comment.new
    comment.save
    expect(comment).to be_invalid
  end

  it 'validates post length to a max of 200 characters' do
    comment = Comment.new(content: 'd' * 201)
    comment.save
    expect(comment).to be_invalid
  end

  it 'should belong to user' do
    t = Comment.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should belong to post' do
    t = Comment.reflect_on_association(:post)
    expect(t.macro).to eq(:belongs_to)
  end
end

