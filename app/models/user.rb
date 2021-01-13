class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attended_events, through: :attendances, class_name: 'Event',
                             foreign_key: 'event_id', source: :event
  has_many :invitations, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  scope :yet_to_be_invited_to, ->(event) { where.not(id: event.invitations.map(&:invitee)) }
  scope :all_except, ->(user) { where.not(id: user.id) }
end
