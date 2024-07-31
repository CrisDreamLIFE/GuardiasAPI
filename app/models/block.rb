class Block < ApplicationRecord
  belongs_to :day
  belongs_to :engineer, optional: true
  has_many :availabilities
end
