require 'rails_helper'

RSpec.describe Reservation do
  let(:reservation) { create(:reservation, start_time: 1.hour.ago.to_time, end_time: Time.now) }
  let(:result) { reservation.disjoint?(new_start_time, new_end_time) }

  describe '#disjoint?' do
    context 'when equal timing' do
      let(:new_start_time) { 1.hour.ago.to_time }
      let(:new_end_time) { Time.now }

      it { expect(result).to be false }
    end

    context 'when intersect' do
      context 'when start time is less than new_end_time' do
        let(:new_start_time) { 2.hours.ago.to_time }
        let(:new_end_time) { 30.minutes.ago.to_time }

        it { expect(result).to be false }
      end

      context 'when end time is more than new_start_time' do
        let(:new_start_time) { 30.minutes.ago.to_time }
        let(:new_end_time) { 1.minute.since.to_time }

        it { expect(result).to be false }
      end
    end

    context 'when start_time equal new_end_time' do
      let(:new_start_time) { 2.hours.ago.to_time }
      let(:new_end_time) { reservation.start_time }

      it { expect(result).to be true }
    end

    context 'when end_time equal new_start_time' do
      let(:new_start_time) { reservation.end_time }
      let(:new_end_time) { 1.hour.since.to_time }

      it { expect(result).to be true }
    end
  end
end
