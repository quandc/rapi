module ControllerMacros
  def login
    before(:each) do
      def login_with(user = double('user'), scope = :user)
        current_user = "current_#{scope}".to_sym
        if user.nil?
          allow(request.env['devise']).to receive(:authenticate!).and_throw(:devise, scope: scope)
          allow(controller).to receive(current_user).and_return(nil)
        else
          allow(request.env['devise']).to receive(:authenticate!).and_return(user)
          allow(controller).to receive(current_user).and_return(user)
        end
        sign_in current_user
      end
    end
  end
end
