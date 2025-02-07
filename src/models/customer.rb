class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :email, type: String
  field :name, type: String
  field :password_hash, type: String
  field :active, type: Boolean, default: true

  has_many :orders

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end 