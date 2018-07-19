class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, presence: true
  validates :book_id, presence: true

  def find_book1
   Book.where("id = ?", :book_id)
  end

  def find_user
    User.where("id = ?", :user_id)
  end
end
