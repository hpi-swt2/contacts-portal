FactoryBot.define do
  factory :note do
    title { "MyString" }
    content { "MyText" }
    # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#implicit-definition
    user factory: :user
  end
end
