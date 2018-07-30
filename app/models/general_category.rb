class GeneralCategory < ApplicationRecord
  has_many :categories
  accepts_nested_attributes_for :categories
  validates :name, presence: true
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
end
