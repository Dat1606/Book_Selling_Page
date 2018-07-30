class Book < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :publisher
  belongs_to :author
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  default_scope -> {order(created_at: :desc)}
  has_many :requests, dependent: :destroy
  has_many :passive_likes, class_name:  Like.name,
    foreign_key: "book_id", dependent: :destroy
  has_many :book_likes, through: :passive_likes, source: :user
  validates :user_id, presence: true
  validates :name, presence: true
  validate  :picture_size
  validates :publisher_id, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true
  validates :picture, presence: true
  validates :number, presence: true
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/

  scope :search, ->q{where "name LIKE \'%#{q}%\'"}
   private

    # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def self.search(search)
  where("name LIKE ? ", "%#{search}%")
  end
end
