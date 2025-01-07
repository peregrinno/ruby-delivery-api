class OrderDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :subtotal, type: Float

  belongs_to :order
  belongs_to :product
end
