class Availability < ApplicationRecord
  belongs_to :engineer
  belongs_to :block
end
