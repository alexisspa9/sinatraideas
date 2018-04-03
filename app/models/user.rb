class User < ActiveRecord::Base
	has_many :ideas
	has_secure_password


	validates :username, presence: { message: "Name can't be blank" }, uniqueness: { message: "Name is already taken" } 
  

  validates :email, presence: { message: "Email can't be blank" }, uniqueness: { message: "Email is already taken" },
  					format: { with: /\w+@\w+\.\w+/,
    					message: "Please use a proper email syntax" }

  validates :password, presence: { message: "Password can't be blank" }

end
