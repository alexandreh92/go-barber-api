require 'spec_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:provider).class_name('User') }
  end
end
