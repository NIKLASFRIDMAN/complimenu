class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  validates :name, presence: true
  validates :category, presence: true

  # SCOPES
  scope :grouped_by_category, -> {
    joins(:item_orders)
    .group_by { |item| item.category }
  }

end
