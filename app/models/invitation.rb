class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: 'User', foreign_key: 'user_id'

  scope :pending, -> { includes(:invitee, :event).where(accepted: false) }
  scope :confirmation_missing, ->(user) { includes(:invitee, :event).where(user_id: user.id).pending }
  scope :for, ->(event, user) { includes(:invitee, :event).find_by(event_id: event, user_id: user) }
end
