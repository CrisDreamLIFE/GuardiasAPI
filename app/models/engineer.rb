class Engineer < ApplicationRecord
    has_many :blocks
    has_many :availabilities
end
