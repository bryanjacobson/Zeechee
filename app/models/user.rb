require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password

  validates :name, :uniqueness => true, :presence => true,
    :length => { :within => 2..40 }
  validates :email, :uniqueness => true, :presence => true,
    :length => { :within => 5..70 }
  validates :password, :confirmation => true,
    :length => { :within => 4..32 },
    :presence => true,
    :if => :password_required?

  before_save :encrypt_new_password

  has_many :topics

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  protected
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end
