FactoryGirl.define do
  factory :post do
    title "First post"
    body "This is the newest post. It needs 20 char to be saved."
    user
    topic
  end
end