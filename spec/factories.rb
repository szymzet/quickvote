FactoryGirl.define do
  factory :poll do
    title 'Poll title'
    after(:create) do |poll|
      poll.questions << FactoryGirl.create(:question, name: 'First') 
      poll.questions << FactoryGirl.create(:question, name: 'Second')
    end
  end

  factory :authenticated_poll, class: Poll do
    title 'Poll requiring authentication'
    require_login true
    after(:create) do |poll|
      poll.questions << FactoryGirl.create(:question, name: 'First') 
      poll.questions << FactoryGirl.create(:question, name: 'Second')
    end
  end

  factory :question do
    name 'Some question'
  end

  factory :user do
    email 'someone@gmail.com'
  end
end
