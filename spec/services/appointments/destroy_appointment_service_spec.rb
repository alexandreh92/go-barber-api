# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Appointments::DestroyAppointmentService, type: :service do
  frozen_date = Time.zone.parse('2022-01-01 00:00:00 UTC')
  let(:appointment) { create(:appointment, date: date) }
  let(:user) { appointment.user }

  subject { described_class.call(user_id: user.id, appointment_id: appointment.id) }

  context 'with success', travel: frozen_date do
    let(:date) { DateTime.tomorrow.at_midday }

    it 'update Appointment with cancelled_at' do
      expect { subject }.to change { appointment.reload.cancelled_at }.from(nil)
                                                                      .to(DateTime.now)
    end
  end

  context 'with error', travel: frozen_date do
    context 'when date is in the past' do
      let(:date) { DateTime.yesterday.at_midday }

      it 'raise Forbidden exception' do
        expect { subject }.to raise_error(Exceptions::CancellationNotInRange)
      end
    end

    context 'when date is not in cancellation range' do
      let(:date) { frozen_date + 1.hour }

      it 'raise Forbidden exception' do
        expect { subject }.to raise_error(Exceptions::CancellationNotInRange)
      end
    end

    context "when user is not the appointment's owner" do
      let(:date) { DateTime.tomorrow.at_midday }
      let(:user) { create(:user) }

      it 'raise Forbidden exception' do
        expect { subject }.to raise_error(Exceptions::Forbidden)
      end
    end
  end
end
