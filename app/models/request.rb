class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :borrow_date, presence: true
  validates :return_date, presence: true
  validate :valid_time
  validate :valid_time2

  def valid_time
    if borrow_date && borrow_date < Date.today
      errors.add(:borrow_date, "can't be in the past")
    end
  end

  def valid_time2
    if return_date && return_date <= borrow_date
      errors.add(:return_date, "is invalid")
    end
  end

  def find_book1
   Book.where("id = ?", :book_id)
  end

  def find_user
    User.where("id = ?", :user_id)
  end
end
