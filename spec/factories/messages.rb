FactoryGirl.define do
  factory :message do
  	user
    category { Faker::Lorem.word }
	content { Faker::Lorem.sentence }
  end
end
