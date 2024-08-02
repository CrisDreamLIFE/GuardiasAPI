class GreedyAssignmentAlgorithm
  def initialize(week, engineers)
    @week = week
    @engineers = engineers
    @blocks = week.days.flat_map(&:blocks)
  end

  def assign
    engineers_availability = get_availability
    engineers_weekly_hours = @engineers.map { |e| [e.id, 0] }.to_h
    engineers_shifts_per_day = Hash.new { |hash, key| hash[key] = [] }

    @blocks.group_by(&:day_id).each do |day_id, blocks|
      blocks.sort_by!(&:time)
      blocks.each do |block|
        engineer_id = available_engineer_with_most_shifts_and_least_hours(
          engineers_availability[block.id], engineers_weekly_hours, engineers_shifts_per_day[day_id]
        )
        if engineer_id
          block.update(engineer_id: engineer_id)
          engineers_weekly_hours[engineer_id] += 1
          engineers_shifts_per_day[day_id] << engineer_id
        end
      end
    end
  end

  private

  def get_availability
    availability = Availability.where(block_id: @blocks.map(&:id)).group_by(&:block_id)
    engineers_availability = {}

    @blocks.each do |block|
      available_engineers = availability[block.id]&.map(&:engineer_id) || []
      engineers_availability[block.id] = available_engineers
    end

    engineers_availability
  end

  def available_engineer_with_most_shifts_and_least_hours(available_engineers, engineers_weekly_hours, day_shifts)
    return nil if available_engineers.empty?

    available_engineers.max_by do |id|
      [day_shifts.count(id), -engineers_weekly_hours[id]]
    end
  end
end
class GreedyAssignmentAlgorithm
  def initialize(week, engineers)
    @week = week
    @engineers = engineers
    @blocks = week.days.flat_map(&:blocks)
  end

  def assign
    engineers_availability = get_availability
    engineers_weekly_hours = @engineers.map { |e| [e.id, 0] }.to_h
    engineers_shifts_per_day = Hash.new { |hash, key| hash[key] = [] }

    @blocks.group_by(&:day_id).each do |day_id, blocks|
      blocks.sort_by!(&:start_time)
      blocks.each do |block|
        engineer_id = available_engineer_with_most_shifts_and_least_hours(
          engineers_availability[block.id], engineers_weekly_hours, engineers_shifts_per_day[day_id]
        )
        if engineer_id
          block.update(engineer_id: engineer_id)
          engineers_weekly_hours[engineer_id] += 1
          engineers_shifts_per_day[day_id] << engineer_id
        end
      end
    end
  end

  private

  def get_availability
    availability = Availability.where(block_id: @blocks.map(&:id)).group_by(&:block_id)
    engineers_availability = {}

    @blocks.each do |block|
      available_engineers = availability[block.id]&.map(&:engineer_id) || []
      engineers_availability[block.id] = available_engineers
    end

    engineers_availability
  end

  def available_engineer_with_most_shifts_and_least_hours(available_engineers, engineers_weekly_hours, day_shifts)
    return nil if available_engineers.empty?

    available_engineers.max_by do |id|
      [day_shifts.count(id), -engineers_weekly_hours[id]]
    end
  end
end
