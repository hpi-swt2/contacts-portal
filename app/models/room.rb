# A room to chat with other users
class Room < ApplicationRecord
  has_many :room_messages,
           dependent: :destroy,
           inverse_of: :room

  GLOBAL_CHAT_ID = 1
end