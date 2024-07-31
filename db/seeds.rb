# Clear existing data
Availability.delete_all
Block.delete_all
Day.delete_all
Week.delete_all
Service.delete_all
Engineer.delete_all

# Create Services
service1 = Service.create!(name: "“Monitoreo Recorrido.cl", start_date: "2024-07-01", end_date: "2024-12-31")

# Helper method to create weeks
def create_week(service, label, start_date, end_date, number, year)
    Week.create!(label: label, start_date: start_date, end_date: end_date, service: service, number: number, year: year)
end

# Create Weeks
week1 = Week.create!(label: "Semana 27 del 2024", start_date: "2024-07-01", end_date: "2024-07-07", service: service1, number: 27, year: 2024)
week2 = Week.create!(label: "Semana 28 del 2024", start_date: "2024-07-08", end_date: "2024-07-14", service: service1, number: 28, year: 2024)
week3 = Week.create!(label: "Semana 29 del 2024", start_date: "2024-07-15", end_date: "2024-07-21", service: service1, number: 29, year: 2024)
week4 = Week.create!(label: "Semana 30 del 2024", start_date: "2024-07-22", end_date: "2024-07-28", service: service1, number: 30, year: 2024)
week5 = Week.create!(label: "Semana 31 del 2024", start_date: "2024-07-29", end_date: "2024-08-04", service: service1, number: 31, year: 2024)
week6 = Week.create!(label: "Semana 32 del 2024", start_date: "2024-08-05", end_date: "2024-08-11", service: service1, number: 32, year: 2024)
week7 = Week.create!(label: "Semana 33 del 2024", start_date: "2024-08-12", end_date: "2024-08-18", service: service1, number: 33, year: 2024)
week8 = Week.create!(label: "Semana 34 del 2024", start_date: "2024-08-19", end_date: "2024-08-25", service: service1, number: 34, year: 2024)
week9 = Week.create!(label: "Semana 35 del 2024", start_date: "2024-08-26", end_date: "2024-09-01", service: service1, number: 35, year: 2024)

# Create Days for Each Week
[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
    ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"].each do |day_label|
        Day.create!(label: day_label, week: week)
    end
end

# Create Engineers
engineer1 = Engineer.create!(name: "Ernesto", color: "#ffcf33")
engineer2 = Engineer.create!(name: "Bárbara", color: "#40f774")
engineer3 = Engineer.create!(name: "Benjamín", color: "#e895f0")
engineer4 = Engineer.create!(name: "Cristian", color: "#8a5ff5")

# Helper method to create start and end times for blocks
def create_block(day, start_time_str)
    start_time = DateTime.parse(start_time_str)
    end_time = start_time + 1.hour
    Block.create!(start_time: start_time, end_time: end_time, day: day)
  end
  
# Create Blocks for Each Day
[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
    week.days.each do |day|
        create_block(day, "2024-07-01T08:00:00")
        create_block(day, "2024-07-01T10:00:00")
        create_block(day, "2024-07-01T11:00:00")
        create_block(day, "2024-07-01T12:00:00")
    end
end

# Create Availabilities for Engineers
[week1, week2, week3, week4, week5, week6, week7, week8, week9].each do |week|
    week.blocks.each do |block|
      Availability.create!(engineer: engineer4, block: block)
    end
  end

# Adding additional availability for the third engineer
[week5, week6, week7, week8, week9].each do |week|
    week.blocks.each do |block|
        Availability.create!(engineer: engineer1, block: block)
        Availability.create!(engineer: engineer2, block: block)
        Availability.create!(engineer: engineer3, block: block)
    end
end