class Message < ActiveRecord::Base
	attr_accessor :event
	belongs_to :user, :foreign_key => :user
end
