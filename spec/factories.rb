FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :manager, :class => User, :aliases => [:checker] do
    password 'secret'
    role 'manager'
    email
  end

  factory :secretary, :class => User, :aliases => [:author] do
    password 'secret'
    role 'secretary'
    email
  end

  factory :consumption do
    sequence(:sequence_number) {|n| n }
    value 100
  end

  factory :bill do
    name 'bill'
    period_start Date.today.beginning_of_month
    period_stop Date.today.next_month.end_of_month
    consumption_unit 'kWh'
    time_unit 'M'
    author

    factory :bill_with_consumptions do
      ignore do
        bills_count 2
      end

      after(:create) do |bill, evaluator|
        FactoryGirl.create_list(:consumption, evaluator.bills_count, :bill => bill)
      end
    end
  end

end
