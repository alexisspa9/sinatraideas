class User < ActiveRecord::Base
	has_many :ideas
	has_secure_password
end