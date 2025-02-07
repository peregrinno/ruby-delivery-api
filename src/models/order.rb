class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  VALID_STATUSES = ["Em analise", "Em preparo", "Pronto", "Enviado", "Entregue", "Cancelado"]

  field :total, type: Float
  field :status, type: String, default: "Em analise"
  field :date, type: DateTime, default: -> { Time.now }

  belongs_to :customer
  has_many :order_details

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }
end 