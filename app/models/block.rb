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
 
  def available_engineers
    # Obtener todos los ingenieros
    all_engineers = Engineer.all
    # Obtener los IDs de los ingenieros disponibles para este bloque
    available_engineer_ids = availabilities.pluck(:engineer_id)
    
    all_engineers.map do |engineer|
      {
        name: engineer.name,
        available: available_engineer_ids.include?(engineer.id)
      }
    end
  end
end
