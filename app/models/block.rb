class Block < ApplicationRecord
  belongs_to :day
  belongs_to :engineer, optional: true
  has_many :availabilities

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day_id, presence: true

  def available?(engineer)
    availabilities.exists?(engineer: engineer)
  end
end
