FactoryGirl.define do
  factory :user do
    pass = Faker::Internet.password
    email { Faker::Internet.email }
    password pass
    password_confirmation pass
    tokens "client_id" => {"token"=>"token", "expiry"=>999999999}
    client_id "client_id"
  end
end
