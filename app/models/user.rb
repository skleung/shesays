require 'bcrypt'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.hash_email(email_addr)
    hashed_email = Digest::SHA1.hexdigest(email_addr.downcase)
  end
end
