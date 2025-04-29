class RcsMessage < ApplicationRecord
    validates :to, presence: true
    validates :from, presence: true
    validates :message_type, presence: true
end
