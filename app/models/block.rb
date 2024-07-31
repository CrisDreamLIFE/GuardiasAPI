class Block < ApplicationRecord
  belongs_to :day
  belongs_to :engineer
end
