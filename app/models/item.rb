class Item < ApplicationRecord
  # ASSOCIATIONS
  has_many :item_orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # VALIDATIONS
  validates :name, presence: true
  validates :category, presence: true

  # SCOPES
  scope :grouped_by_category, -> {
    group_by { |item| item.category }
  }

  def total_reviews
    total_review = 0
    self.reviews.each do |review|
      total_review += review.upvote
    end
    total_review
  end

end
