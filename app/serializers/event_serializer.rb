class EventSerializer < ActiveModel::Serializer
  attributes :event

  def event
  	serialization_options[:event]
  end
end
