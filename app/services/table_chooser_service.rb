class TableChooserService
  def initialize(params)
    @count_people = params[:count_people]
    @start_time = params[:start_time].to_time
    @end_time = params[:end_time].to_time
  end

  def call
    choose_table
  end

  private

  def choose_table
    tables = Table.where('count_people >= ?', @count_people).includes(:reservations)
    tables.find do |table|
      table.reservations.any? { |reserv| reserv.disjoint?(@start_time, @end_time) } || table.reservations.empty?
    end
  end
end
