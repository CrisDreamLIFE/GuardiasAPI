class Engineer < ApplicationRecord
  has_many :availabilities
  has_many :blocks, through: :availabilities

  validates :name, presence: true
  validates :color, presence: true
end
