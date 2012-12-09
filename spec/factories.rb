FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    password 'secret'
    role 'manager'
    email
  end
end
