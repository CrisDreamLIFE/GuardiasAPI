# Limpiar tablas
Availability.delete_all
Block.delete_all
Day.delete_all
Week.delete_all
Service.delete_all
Engineer.delete_all

# Servicios
service1 = Service.create!(name: "“Monitoreo Recorrido.cl", start_date: "2024-07-01", end_date: "2024-12-31")


# Semanas
week1 = Week.create!(label: "Semana 32 del 2024", start_date: "2024-08-05", end_date: "2024-08-11", service: service1, number: 32, year: 2024)
week2 = Week.create!(label: "Semana 33 del 2024", start_date: "2024-08-12", end_date: "2024-08-18", service: service1, number: 33, year: 2024)
week3 = Week.create!(label: "Semana 34 del 2024", start_date: "2024-08-19", end_date: "2024-08-25", service: service1, number: 34, year: 2024)
week4 = Week.create!(label: "Semana 35 del 2024", start_date: "2024-08-26", end_date: "2024-09-01", service: service1, number: 35, year: 2024)
week5 = Week.create!(label: "Semana 36 del 2024", start_date: "2024-09-02", end_date: "2024-09-08", service: service1, number: 36, year: 2024)
week6 = Week.create!(label: "Semana 37 del 2024", start_date: "2024-09-09", end_date: "2024-09-15", service: service1, number: 37, year: 2024)
week7 = Week.create!(label: "Semana 38 del 2024", start_date: "2024-09-16", end_date: "2024-09-22", service: service1, number: 38, year: 2024)
week8 = Week.create!(label: "Semana 39 del 2024", start_date: "2024-09-23", end_date: "2024-09-29", service: service1, number: 39, year: 2024)
week9 = Week.create!(label: "Semana 40 del 2024", start_date: "2024-09-30", end_date: "2024-10-06", service: service1, number: 40, year: 2024)

# Días
[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
  ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"].each_with_index do |day_label, index|
    date = week.start_date.to_date + index
    formatted_date = date.strftime("%d/%m/%Y")
    Day.create!(label: "#{day_label} - #{formatted_date}", week: week)
  end
end

# Ingenieros
engineer1 = Engineer.create!(name: "Ernesto", color: "#ffcf33")
engineer2 = Engineer.create!(name: "Bárbara", color: "#40f774")
engineer3 = Engineer.create!(name: "Benjamín", color: "#e895f0")
engineer4 = Engineer.create!(name: "Cristian", color: "#8a5ff5")

# Bloques
def create_blocks_for_day(day)
  ["08:00", "10:00", "12:00", "14:00"].each do |time_str|
    start_time = DateTime.parse("#{day.week.start_date.to_date} #{time_str}")
    end_time = start_time + 1.hour
    Block.create!(start_time: start_time, end_time: end_time, day: day)
  end
end

[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
  week.days.each do |day|
    create_blocks_for_day(day)
  end
end

# Diposnibilidad
[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
  week.blocks.each do |block|
    Availability.create!(engineer: engineer4, block: block)
  end
end

[week5, week6, week7, week8, week9].each do |week|
  week.blocks.each do |block|
    if week.label == "Semana 31 del 2024"
      Availability.create!(engineer: engineer1, block: block)
    else
      Availability.create!(engineer: engineer2, block: block)
      Availability.create!(engineer: engineer3, block: block)
    end    
  end
end
