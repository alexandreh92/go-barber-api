require 'spec_helper'

RSpec.describe Users::ValidatePasswordService, type: :service do
  let!(:user) { create(:user, password: password, password_confirmation: password) }
  let(:password) { '123123' }

  subject do
    described_class.call(
      user_id: user.id,
      new_password: new_password,
      new_password_confirmation: new_password_confirmation,
      current_password: current_password
    )
  end

  context 'with success' do
    let(:new_password) { '12345' }
    let(:new_password_confirmation) { new_password }
    let(:current_password) { password }

    it 'do not raise errors' do
      expect { subject }.not_to raise_error
    end
  end

  context 'with failure' do
    context 'when current_password is not the same' do
      let(:new_password) { '12345' }
      let(:new_password_confirmation) { new_password }
      let(:current_password) { '4321' }

      it 'raise ActiveRecord::RecordInvalid' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when password and password_confirmation are not the same' do
      let(:new_password) { '12345' }
      let(:new_password_confirmation) { '4321' }
      let(:current_password) { password }

      it 'raise ActiveRecord::RecordInvalid' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
