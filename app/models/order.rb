class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :customer_id, type: String
  field :total, type: Float
  field :order_date, type: Time
  field :status, type: String, default: -> { STATUS_UIDS[:waiting_approval] }
  field :last_status_update, type: Time, default: -> { Time.now }

  belongs_to :customer
  has_many :order_details

  STATUS_UIDS = {
    waiting_approval: 'waiting_approval',
    in_preparation: 'in_preparation',
    ready: 'ready',
    in_route: 'in_route',
    delivered: 'delivered'
  }.freeze

  STATUS_TRANSITIONS = {
    'waiting_approval' => ['in_preparation'],
    'in_preparation' => ['ready'],
    'ready' => ['in_route'],
    'in_route' => ['delivered']
  }.freeze

  def can_change_status_to?(new_status)
    return false if status == STATUS_UIDS[:delivered] 
    return true if STATUS_TRANSITIONS[status]&.include?(new_status)

    false
  end
end
