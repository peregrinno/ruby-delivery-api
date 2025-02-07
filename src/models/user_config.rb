class UserConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  field :permissions, type: Array, default: []
  field :last_active, type: DateTime

  belongs_to :user

  validates :permissions, presence: true
end 