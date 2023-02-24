class Reservation < ApplicationRecord
  belongs_to :table



  def disjoint?(new_start_time, new_end_time)
    start_time.to_time >= new_end_time || end_time.to_time <= new_start_time
  end
end
