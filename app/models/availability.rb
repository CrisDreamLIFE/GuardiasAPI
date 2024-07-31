class Availability < ApplicationRecord
  belongs_to :engineer
  belongs_to :block

  validates :engineer_id, presence: true
  validates :block_id, presence: true
end
