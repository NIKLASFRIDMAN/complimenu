class Item < ApplicationRecord
  # ASSOCIATIONS
  has_many :item_orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # VALIDATIONS
  validates :name, presence: true
  validates :category, presence: true

  # SCOPES
  scope :grouped_by_category, -> {
    joins(:item_orders)
    .group_by { |item| item.category }
  }

end
