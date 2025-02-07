class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :value, type: Float

  has_many :order_details

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
end 