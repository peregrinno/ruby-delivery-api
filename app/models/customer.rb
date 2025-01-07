require 'bcrypt'

class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :password_digest, type: String

  validates :email, presence: true, uniqueness: true

  def password=(new_password)
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password
  end
end
