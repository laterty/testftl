FactoryBot.define do
  factory :reservation do
    table
    start_time { 1.hour.ago.to_time }
    end_time { Time.now }
  end
end
