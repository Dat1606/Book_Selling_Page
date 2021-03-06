class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name , presence: true
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
end
