require "application_responder"

class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  # before_action :configure_permitted_parameters, if: :devise_controller?
  include Devise::Controllers::Helpers
  # acts_as_token_authentication_handler_for User, fallback_to_devise: false
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  self.responder = ApplicationResponder
  respond_to :json #:html
  # include ActionView::Layouts
  protected
  	def authenticate!
  	  user = User.get_user(params[:client_id],params[:token])
      unless user
        render json: {"errors":["Authorized users only."]}, status: 401
      end
      user
    end
end
