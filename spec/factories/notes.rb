FactoryBot.define do
  factory :note do
    title { "MyString" }
    content { "MyText" }
    user { nil }
  end
end
