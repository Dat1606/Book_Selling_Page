class Category < ApplicationRecord
  belongs_to :user
  has_many :books
  validates :name, presence: true
  default_scope -> { order(created_at: :desc) }

  def self.search(search)
  where("name LIKE ? ", "%#{search}%")
  end
end
