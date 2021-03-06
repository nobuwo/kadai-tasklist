class User < ApplicationRecord
  before_save {self.email.downcase!}
  
  has_many :tasks
  
  validates :name, presence: true, length: {maximum: 10}
  validates :email, presence: true, length: {maximum: 100}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}
  
  has_secure_password
end
