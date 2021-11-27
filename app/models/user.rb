class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friend_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :pending_friend_requests, source: :user
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def confirm_friend(user)
    friendship = inverse_friendships.find { |inverse_friendship| inverse_friendship.user == user }
    friendship.confirmed = true
    friendship.save
    Friendship.create!(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end

