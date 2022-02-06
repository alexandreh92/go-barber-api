# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {
      is_expected.to have_many(:notifications)
        .class_name('Notification')
        .with_foreign_key('provider_id')
    }

    it {
      is_expected.to have_many(:user_appointments)
        .class_name('Appointment')
        .with_foreign_key('user_id')
    }

    it {
      is_expected.to have_many(:provider_appointments)
        .class_name('Appointment')
        .with_foreign_key('provider_id')
    }
  end
end
