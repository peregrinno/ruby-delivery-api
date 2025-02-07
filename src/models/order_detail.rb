class OrderDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :sub_total, type: Float

  belongs_to :order
  belongs_to :product

  validates :sub_total, presence: true, numericality: { greater_than: 0 }
end 