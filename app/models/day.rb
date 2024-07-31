class Day < ApplicationRecord
  belongs_to :week
  has_many :blocks

  validates :label, presence: true
  validates :week_id, presence: true
end
