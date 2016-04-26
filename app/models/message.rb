# Class Message
class Message < ActiveRecord::Base
  attr_accessor :event
  belongs_to :user, dependent: :destroy, foreign_key: :user_id
end
