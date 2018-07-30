class Category < ApplicationRecord
  belongs_to :general_category
  has_many :books
  validates :name, presence: true
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  default_scope -> { order(created_at: :desc) }

  def self.search(search)
  where("name LIKE ? ", "%#{search}%")
  end
end
