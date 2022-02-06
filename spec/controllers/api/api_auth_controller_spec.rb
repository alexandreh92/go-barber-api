# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::ApiAuthController do
  controller do
    def test_record_not_found
      raise ActiveRecord::RecordNotFound
    end
  end

  before :each do
    routes.draw do
      get 'test_record_not_found' => 'api/api_auth#test_record_not_found'
    end
  end

  it 'rescues from ActiveRecord::RecordNotFound' do
    get :test_record_not_found
    expect(response).to have_http_status(:unauthorized)
    expect(JSON.parse(response.body)).to include_json(
      {
        error: /Invalid credentials/
      }
    )
  end
end
