class MessagesSerializer < ActiveModel::Serializer
  attributes :data, :event

  def data
  	json = []
  	object.each do |item|
  		token = item.user.tokens[item.user.tokens.keys.first]["last_token"] rescue nil
  		json << { category: item.category, context: item.content,
    			  user: item.user.email, token: token
    			}
   	end
   	json
  end

  def event
  	serialization_options[:event]
  end

  
end
