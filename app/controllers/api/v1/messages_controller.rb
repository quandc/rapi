class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate!

  def create
    @message = Message.new(user: self.authenticate!,
      content: message_params[:content],category: message_params[:category])
    if @message.save
      render json: success("Create Success", 200)
    else
      render json: error("Error", 404)
    end
  end

  def show
    @messages = Message.where(:category => message_params[:category])
    if @messages
      render json: @messages,
        each_serializer: MessagesSerializer,
        root: "result",
        status: :ok,
        event: "get_message"
    else
      render json: error("404 Error", 404)
    end
  end

  def destroy
    @message = Message.find_by(user: self.authenticate!, id: message_params[:id])
    if @message
      @message.destroy
      render json: success("Delete Success", 200)
    else
      render json: error("Error", 404)
    end
  end

  def update

  end

  def index
    @messages = Message.all
    if @messages
      render json: @messages,
        serializer: MessagesSerializer,
        root: "results",
        status: :ok,
        event: "get_all_message"
    else
      render json: error("404 Error", 404)
    end
  end

  private

    def message_params
      params.permit(:id, :content, :category, :client_id, :token)
    end

    def error(text = "404 Error", status = 404)
      {error: {message: text, status: status}}
    end

    def success(text = "200 Success", status = 200)
      {success: {message: text, status: status}}
    end

    def public_route
      render json: {
        data: {
          message: "Everyone can access this.",
          user: @user
        }
        }, status: 200
    end

    def members_only
      if @user
        render json: {
          data: {
            message: "Welcome #{@user.name}",
            user: @user
          }
          }, status: 200
      else
          render json: {
            errors: ["Authorized users only."]
            }, status: 401
      end
    end
end
