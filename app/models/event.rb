class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many   :attendances, dependent: :destroy
  has_many   :attendees, through: :attendances, class_name: 'User',
                       foreign_key: 'user_id', source: :user
  has_many :invitations, dependent: :destroy

  validates :description, :date, :location, presence: true

  scope :previous, -> { where('date < ?', Time.zone.now) }
  scope :upcoming, -> { where('date > ?', Time.zone.now) }

  def english_date
    date.strftime("%m/%d/%Y")
  end

  def future
    date > Time.zone.now
  end
end
