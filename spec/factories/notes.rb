FactoryBot.define do
  factory :note do
    title { "MyString" }
    content { "MyText" }
    user { FactoryBot.create(:user) }
  end
end
