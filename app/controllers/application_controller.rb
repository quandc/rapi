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
      client_id = params[:client_id] || params[:message][:client_id] rescue nil
      token = params[:token] || params[:message][:token] rescue nil
      email = Event.find(:token=> token, :client_id=> client_id).to_a.first.email rescue nil
      if email && session["#{client_id}:#{token}"]
        return session["#{client_id}:#{token}"]
      end
      session["#{client_id}:#{token}"] = User.get_user( email )
      unless session["#{client_id}:#{token}"]
        render json: { 'errors' => ['Authorized users only.'] }, status: 401
      end
    end
end
