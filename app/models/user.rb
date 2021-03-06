class User < ActiveRecord::Base
  has_many :surveys
  has_many :answers
  has_many :questions, through: :answers
  has_many :completed_surveys

  validates :email, uniqueness: true

  include BCrypt
  
  def password
    @password ||= Password.new(password_hash)
  end
  
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    
    user.password == password ? user : nil
  end

end


