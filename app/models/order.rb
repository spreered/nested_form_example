class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  accepts_nested_attributes_for :order_items, reject_if: ->(attributes){ attributes['product_id'].blank? }, allow_destroy: true
end
