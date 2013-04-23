FactoryGirl.define do

  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password 'pleaseplease'
    password_confirmation 'pleaseplease'
  end

  factory :press_type do
    name "My Press 3000"
  end

  factory :press_type_cost do
    description "Hourly"
    user_id FactoryGirl.create(:user)
    press_type_id FactoryGirl.create(:press_type).id
    cost 10.00
  end
end
