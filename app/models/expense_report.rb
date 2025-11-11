class ExpenseReport < ApplicationRecord
  belongs_to :user
  has_one_attached :receipt

  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }

  validates :title, :category, :amount, :date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
