class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Float

  validates :name, presence: true
end
