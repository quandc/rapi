# Class Message
class Message < ActiveRecord::Base
  attr_accessor :event
  belongs_to :user, foreign_key: :user_id#dependent: :destroy, 
end
