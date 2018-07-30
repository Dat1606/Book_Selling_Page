class User < ApplicationRecord
  has_many :categories,  dependent: :destroy
  has_many :books, dependent: :destroy
  has_many  :likes, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  before_save {self.email = email.downcase}
  validates :name,  presence: true, length: {maximum: Settings.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.password.minimum}
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/

  has_many :active_likes, class_name:  Like.name,
    foreign_key: "user_id", dependent: :destroy
  has_many :user_like, through: :active_likes, source: :book
  attr_accessor :remember_token

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end


  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Category.where("user_id = ?", id)
  end

  def find_requests
    Request.where("user_id = ?", id)
  end

  def self.search(search)
  where("name LIKE ? ", "%#{search}%")
  end

   # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def request book
    request << book
  end

  def like book_id
    user_like << book_id
  end

  def unlike book_id
    user_like.delete book_id
  end

  def like? book_id
    user_like.include? book_id
  end
end
