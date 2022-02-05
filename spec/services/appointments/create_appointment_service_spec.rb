# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Appointments::CreateAppointmentService, type: :service do
  frozen_date = Time.zone.parse('2022-01-01 00:00:00 UTC')
  let(:user) { create(:user) }
  let(:provider) { create(:user, :provider) }
  let(:date) { DateTime.tomorrow.at_midday }

  subject do
    described_class.call(user_id: user.id, provider_id: provider.id, date: date.to_s)
  end

  context 'with success', travel: frozen_date do
    it 'creates an appointment' do
      expect { subject }.to change { Appointment.count }.from(0).to(1)
    end

    it 'returns new appointment object' do
      expect(subject).to be_kind_of(Appointment)
    end
  end

  context 'with failure', travel: frozen_date do
    context 'when user is not a provider' do
      let(:provider) { create(:user, provider: false) }

      it 'throws NotProvider exception' do
        expect { subject }.to raise_error(Exceptions::NotProvider)
      end
    end

    context 'when date is in the past' do
      let(:date) { DateTime.yesterday.at_midday }

      it 'throws PastDatesNotAllowed exception' do
        expect { subject }.to raise_error(Exceptions::PastDatesNotAllowed)
      end
    end

    context 'when date is not available' do
      let!(:appointment) do
        create(:appointment, user: user, provider: provider, date: date)
      end

      it 'throws DateNotAvailable exception' do
        expect { subject }.to raise_error(Exceptions::DateNotAvailable)
      end
    end
  end
end
