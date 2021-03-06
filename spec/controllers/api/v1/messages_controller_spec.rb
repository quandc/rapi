require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
	let(:user) { create(:user) }
  let(:message) { create(:message, user: user) }

  before(:each) do
		# headers = {
		#       "ACCEPT" => "application/json",     # This is what Rails 4 accepts
		# }
		# post "/api/v1/auth/sign_in", { :user => {email: user.email, password: user.password } }, headers
		user.tokens["client_id"] = { token: "token", expiry: 99999999999999 }
		user.save
	end
	
	describe "GET list message" do
		it "request uri without token" do
			get :index
			expect(response).to have_http_status(401)
			expect(response.body).to eq "{\"errors\":[\"Authorized users only.\"]}"
		end

		it "request uri with token" do
			get :index, {token: "token", client_id: "client_id"}
			expect(response).to have_http_status(200)
			expect(response.body).not_to eq "{\"errors\":[\"Authorized users only.\"]}"
		end
	end

	describe "Create new message" do
		it "post uri without token or wrong token" do
			post :create, {token: "token1", client_id: "client_id1"}
			expect(response).to have_http_status(401)
			expect(response.body).to eq "{\"errors\":[\"Authorized users only.\"]}"
		end

		it "post uri with token" do
			post :create, {token: "token", client_id: "client_id", category: "book", content: "hello"}
			expect(response).to have_http_status(202)
			expect(response.body).to eq "{\"success\":{\"message\":\"Create Success\",\"status\":202}}"
			mes = Message.find_by(category: "book")
			expect(mes.content).to eq "hello"
		end
	end

	describe "Delete message" do
		it "delete uri with token and don't have any message" do
			delete :destroy , query: {token: "token", client_id: "client_id" }, :id => 1
			expect(response).to have_http_status(400)
		end

		it "delete uri with token" do
			FactoryGirl.create(:message, user: user)
			total_message = Message.count
			delete :destroy , query: {token: "token", client_id: "client_id" }, :id => 1
			expect(response).to have_http_status(202)
			expect(response.body).to eq "{\"success\":{\"message\":\"Delete Success\",\"status\":202}}"
			expect(Message.count).to eq (total_message - 1)
		end
	end

	describe "Show message" do
		it "show message without token or wrong token" do
			get :show, :id => 1
			expect(response).to have_http_status(401)
			expect(response.body).to eq "{\"errors\":[\"Authorized users only.\"]}"
		end

		it "show uri with token" do
			get :show, :id => 1, query: {token: "token", client_id: "client_id" }
			expect(response).to have_http_status(200)
			expect(response.body).to eq "{\"result\":[]}"
		end
	end

	describe "update message" do
		it "update message with token and don't have any message" do
			put :update, :id => 1, query: {token: "token", client_id: "client_id" }
			expect(response).to have_http_status(400)
			# expect(Message.count).to eq (total_message - 1)
		end
		it "update message with token and message exists" do
			FactoryGirl.create(:message, user: user)
			put :update, :id => 1, query: {token: "token", client_id: "client_id" }
			expect(response).to have_http_status(202)
			expect(response.body).to eq "{\"success\":{\"message\":\"Update Success\",\"status\":202}}"
			# expect(Message.count).to eq (total_message - 1)
		end
	end
end
