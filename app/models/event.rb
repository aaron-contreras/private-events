class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many   :attendances
  has_many   :attendees, through: :attendances, class_name: 'User',
                       foreign_key: 'user_id', source: :user
  validates :description, :date, :location, presence: true
  scope :past, -> { where('date < ?', Time.zone.now) }
  scope :upcoming, -> { where('date > ?', Time.zone.now) }
end

