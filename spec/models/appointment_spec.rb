require 'spec_helper'

RSpec.describe Appointment, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:provider).class_name('User') }
    it { is_expected.not_to allow_value(nil).for(:date) }
  end

  describe 'scopes' do
    describe '#not_cancelled' do
      let!(:appointment) { create(:appointment) }
      let!(:cancelled_appointment) { create(:appointment, cancelled_at: DateTime.now) }

      it 'do not return cancelled appointment' do
        expect(described_class.not_cancelled).not_to include(cancelled_appointment)
      end

      it 'return valid appointments' do
        expect(described_class.not_cancelled).to include(appointment)
      end
    end
  end

  describe 'methods' do
    frozen_date = Time.zone.parse('2022-01-01 12:00:00 UTC')

    let(:appointment) { create(:appointment, date: date) }

    describe '#cancellable?', travel: frozen_date do
      context 'when appointment date is greater than two hours by now' do
        let(:date) { DateTime.now.at_end_of_day }

        it 'returns true' do
          expect(appointment.cancellable?).to be_truthy
        end
      end

      context 'when appointment date is lesser than two hours by now' do
        let(:date) { DateTime.now + 1.hour }

        it 'returns false' do
          expect(appointment.cancellable?).to be_truthy
        end
      end
    end

    describe '#past?', travel: frozen_date do
      context 'appointment date is greater than now' do
        let(:date) { DateTime.now - 1.hour }

        it 'returns true' do
          expect(appointment.cancellable?).to be_truthy
        end
      end

      context 'appointment date is lesser than now' do
        let(:date) { DateTime.now + 1.hour }

        it 'returns false' do
          expect(appointment.cancellable?).to be_truthy
        end
      end
    end
  end
end
