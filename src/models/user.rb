class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :email, type: String
  field :username, type: String
  field :password_hash, type: String
  field :active, type: Boolean, default: true

  has_one :user_config

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end 