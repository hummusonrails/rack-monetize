# frozen_string_literal: true

require_relative '../../lib/rack/monetize'

RSpec.describe Rack::Monetize::ProcessMonetizeState do
  let(:app) do
    Rack::Builder.new do
      use Rack::Monetize::ProcessMonetizeState
      run(->(env) { [200, env] })
    end 
  end

  let(:app_pending_param_status) do
    {
      'monetization_state' => 'pending'
    }
  end

  let(:app_started_param_status) do
    {
      'monetization_state' => 'started'
    }
  end

  let(:app_stopped_param_status) do
    {
      'monetization_state' => 'stopped'
    }
  end

  let(:app_invalid_params) do
    {
      'monetization_state' => 'not_valid'
    }
  end

  context 'monetize checks with invalid status' do
    it 'returns a 403 if status is not found' do
      response = Rack::MockRequest.new(app).post('/', params: {'monetization_state' => 'some_value'})
      expect(response.status).to eq(403)
    end
  end

  context 'POST requests' do
    it 'passes requests through to the controller for pending monetization status' do
      response = Rack::MockRequest.new(app).post('/', params: app_pending_param_status)
      expect(response.status).to eq(200)
    end

    it 'passes requests through to the controller for stopped monetization status' do
      response = Rack::MockRequest.new(app).post('/', params: app_stopped_param_status)
      expect(response.status).to eq(200)
    end

    it 'passes requests through to the controller for started monetization status' do
      response = Rack::MockRequest.new(app).post('/', params: app_started_param_status)
      expect(response.status).to eq(200)
    end

    it 'returns a 403 if monetize status is not valid' do
      response = Rack::MockRequest.new(app).post('/', params: app_invalid_params)
      expect(response.status).to eq(403)
    end
  end

  context 'GET requests' do
    it 'passes requests through to the controller for pending monetization statuses' do
      response = Rack::MockRequest.new(app).get('/', params: app_pending_param_status)
      expect(response.status).to eq(200)
    end

    it 'passes requests through to the controller for started monetization statuses' do
      response = Rack::MockRequest.new(app).get('/', params: app_started_param_status)
      expect(response.status).to eq(200)
    end

    it 'passes requests through to the controller for stopped monetization statuses' do
      response = Rack::MockRequest.new(app).get('/', params: app_stopped_param_status)
      expect(response.status).to eq(200)
    end

    it 'returns a 403 HTTP response for invalid statuses' do
      response = Rack::MockRequest.new(app).get('/', params: app_invalid_params)
      expect(response.status).to eq(403)
    end
  end

  context 'without a monetization_state parameter' do
    it 'ignores any requests that do not contain the parameter' do
      response = Rack::MockRequest.new(app).post('/', params: {'example' => 'here'})
      expect(response.status).to eq(200)
    end
  end
end
