# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Registration', type: :request do
  let(:sign_up_url) { '/auth/' }
  let(:signup_params) do
    {
      email: 'user@example.com',
      password: '1234567',
      password_confirmation: '1234567'
    }
  end

  describe 'Email registration method' do
    context 'when signup params are valid' do
      before do
        post sign_up_url, params: signup_params
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns authentication header with correct attributes' do
        expect(response.headers['access-token']).to be_present
      end

      it 'returns client in authentication header' do
        expect(response.headers['client']).to be_present
      end

      it 'returns expiry in authentication header' do
        expect(response.headers['expiry']).to be_present
      end

      it 'returns uid in authentication header' do
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when signup params are invalid' do
      before { post sign_up_url }

      it 'returns unprocessable entity 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
