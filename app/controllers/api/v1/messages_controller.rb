# Class MessagesController
class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate!

  # create new message from client with token access
  # example:
  # curl -XPOST -s --form-string "token=TOKEN" --form-string "client_id=CLIENT_ID" --form-string "content=abc123" --form-string "category=book" http://localhost:3000/api/v1/messages
  def create
    @message = Message.new(user: authenticate!, content:
      message_params[:content], category: message_params[:category])
    if @message.save
      render json: success('Create Success', 202), status: 202
    else
      render json: error('Error', 400), status: 400
    end
  end


  # get a message object based on :id if exist
  # example
  # curl -XGET http://localhost:3000/api/v1/messages/:id?token=TOKEN&client_id=CLIENT_ID
  def show
    @messages = authenticate!.messages.where(category: message_params[:category])
    if @messages
      render json: @messages, each_serializer: MessagesSerializer, root:
      'result', status: :ok, event: 'get_message'
    else
      render json: error('Error', 400), status: 400
    end
  end


  # remove message object based on :id
  # example
  # curl -XDELETE http://localhost:3000/api/v1/messages/:id?token=TOKEN&client_id=CLIENT_ID
  def destroy
    @message = authenticate!.messages.find_by(id: message_params[:id])
    if @message
      @message.destroy
      render json: success('Delete Success', 202), status: 202
    else
      render json: error('Error', 400), status: 400
    end
  end

  # update message object based on :id if exist
  # example
  # curl -XDELETE http://localhost:3000/api/v1/messages/:id?token=TOKEN&client_id=CLIENT_ID
  def update
    @message = authenticate!.messages.find_by(id: message_params[:id])
    if @message
      @message.update_attributes(message_params.except!(:client_id, :token, :id))
      render json: success('Update Success', 202), status: 202
    else
      render json: error('Error', 400), status: 400
    end
  end

  # fetch all message from client
  # example
  # curl -XGET http://localhost:3000/api/v1/messages?token=TOKEN&client_id=CLIENT_ID
  def index
    @messages = authenticate!.messages
    if @messages
      render json: @messages,
        serializer: MessagesSerializer,
        root: 'results',
        status: :ok,
        event: 'get_all_message'
    else
      render json: error('Error', 400), status: 400
    end
  end

  private
    def message_params
      params.has_key?(:query) ? params.permit(:id).merge!(params.require(:query)
        .permit(:content, :category, :client_id, :token))
      : params.permit(:id, :content, :category, :client_id, :token)
    end

    def error(text = 'Not Found', status = 404)
      {error: {message: text, status: status}}
    end

    def success(text = 'Success', status = 200)
      {success: {message: text, status: status}}
    end

end
  