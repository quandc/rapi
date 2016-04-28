require "ohm/expire"

class Event < Ohm::Model
  include Ohm::Expire
  include Ohm::DataTypes
  include Ohm::Timestamps

  attribute :email
  attribute :token
  attribute :client_id

  index :client_id
  index :token

  expire 3600
end