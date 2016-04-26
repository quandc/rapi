require 'application_responder'

# Class ApplicationController
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

    # check user exists via token and client_id
    def authenticate!
      client_id = params[:client_id] || params[:query][:client_id] rescue nil
      token = params[:token] || params[:query][:token] rescue nil
      user = User.get_user(client_id, token)
      unless user
        render json: { 'errors' => ['Authorized users only.'] }, status: 401
      end
      user
    end
end
