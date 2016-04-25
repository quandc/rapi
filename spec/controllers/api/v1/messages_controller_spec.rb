require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
	let(:user) { create(:user, tokens: {"client_id" => {"token"=>"token", "expiry"=>999999999} }) }
    let(:message) { create(user: user) }
	before(:context) do
		# headers = {
		#       "ACCEPT" => "application/json",     # This is what Rails 4 accepts
		# }
		# post "/api/v1/auth/sign_in", { :user => {email: user.email, password: user.password } }, headers
		user.tokens["client_id"] = {"token"=>"token", "expiry"=>999999999}
		user.save!
	end

	describe "GET list" do
		it "request uri without token" do
			byebug
			get :index
			expect(response).to have_http_status(401)
			expect(response.body).to eq "{\"errors\":[\"Authorized users only.\"]}"
		end

		# it "request uri with token" do
		# 	get :index
		# 	expect(response).to have_http_status(401)
		# 	expect(response.body).to eq "{\"errors\":[\"Authorized users only.\"]}"
		# end
	end
end
