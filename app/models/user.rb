class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
         validates :name, presence: true
         validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
         validates :password, presence: true, length: { minimum: 6 }
         
end
