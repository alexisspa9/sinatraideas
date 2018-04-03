class Idea < ActiveRecord::Base
	belongs_to :user
	validates :keimeno, presence: { message: "Content can't be blank" }
end