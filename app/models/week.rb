class Week < ApplicationRecord
  belongs_to :service
  has_many :days
end
