require 'rails_helper'

RSpec.describe Post do
  it 'validates post presence' do
    post = Post.new
    post.save
    expect(post).to be_invalid
  end

  it 'validates post length' do
    post = Post.new(content: 'a' * 1001)
    post.save
    expect(post).to be_invalid
  end

  it 'should have many comments' do
    t = Post.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many likes' do
    t = Post.reflect_on_association(:likes)
    expect(t.macro).to eq(:has_many)
  end
end

