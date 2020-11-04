FactoryBot.define do
  factory :note do
    title { "Note title" }
    content { "Note content" }
    # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#implicit-definition
    user factory: :user
  end
end
