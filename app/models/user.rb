class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :tasks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :email

	validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
  message: "only letters allowed"  }
  
  validates :first_name, :last_name, length: { in: 2..30,
  message: "your name is too long"  }
  
  validates :email, length: { maximum: 60, message: "email too long" },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "wrong email format" },
  uniqueness: { case_sensitive: false }
  before_save { email.downcase! }
  
  validates :password, presence: true, length: { minimum: 6 }, :on => :create

  def generate_new_authentcation_token
	token = User.generate_unique_secure_token
    update_attributes authentication_token: token
  end
end
