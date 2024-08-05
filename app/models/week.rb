class Week < ApplicationRecord
  belongs_to :service
  has_many :days
  has_many :blocks, through: :days

  validates :label, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number, presence: true
  validates :year, presence: true

  def self.permitted_attributes
    [:label, :start_date, :end_date, :service_id, :number, :year]
  end

  def summary_engineers
    engineers_turnos = self.blocks.joins(:engineer)
                                   .group('engineers.id')
                                   .select('engineers.*, COUNT(blocks.id) as shift_count')
  end
end
