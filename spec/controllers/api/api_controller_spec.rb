require 'spec_helper'

RSpec.describe Api::ApiController do
  controller do
    skip_before_action :authenticate_user!

    def test_record_not_found
      raise ActiveRecord::RecordNotFound
    end

    def test_record_invalid
      raise ActiveRecord::RecordInvalid
    end

    def test_gobarber_exception
      raise Exceptions::NotProvider
    end

    def test_unhandled_exception
      raise StandardError
    end
  end

  before :each do
    routes.draw do
      get 'test_record_not_found' => 'api/api#test_record_not_found'
      get 'test_record_invalid' => 'api/api#test_record_invalid'
      get 'test_gobarber_exception' => 'api/api#test_gobarber_exception'
      get 'test_gobarber_exception' => 'api/api#test_unhandled_exception'
    end
  end

  it 'rescues from ActiveRecord::RecordNotFound' do
    get :test_record_not_found
    expect(response).to have_http_status(:unauthorized)
  end

  it 'rescues from ActiveRecord::RecordInvalid' do
    get :test_record_invalid
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'rescues from ActiveRecord::RecordInvalid' do
    get :test_gobarber_exception
    expect(response).to have_http_status(Exceptions::NotProvider.new.http_code)
  end

  it 'rescues from StandardError' do
    get :test_unhandled_exception
    expect(response).to have_http_status(:internal_server_error)
  end
end
