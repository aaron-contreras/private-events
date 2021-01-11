class User < ApplicationRecord
  has_many :events
  has_many :attendances
  has_many :attended_events, through: :attendances, class_name: 'Event',
                             foreign_key: 'event_id', source: :event

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
end
