# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.describe 'Users', type: :request do
  let(:active_users) { create_list :user, 10 }
  let(:blocked_users) { create_list :user, 3, :blocked_user }
  let(:current_user) { active_users.sample }
  let(:auth_headers) { current_user.create_new_auth_token }

  describe 'GET /api/v1/users' do
    context 'when authenticated user' do
      before { get '/api/v1/users', headers: auth_headers }

      it 'returns result' do
        expect(JSON.parse(response.body)).not_to be_empty
      end

      it 'returns only active users' do
        response_users = JSON.parse(response.body).sort_by { |a| a['id'] }.to_json
        json_user = active_users.map { |user| UserSerializer.new(user) }.to_json
        expect(response_users).to eq(json_user)
      end

      it 'returns as many user as are active' do
        expect(JSON.parse(response.body).length).to be(active_users.length)
      end

      it 'has http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get list of users' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get '/api/v1/users' }

      it 'has http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    let(:active_user_id) { active_users.sample.id }
    let(:blocked_user_id) { blocked_users.sample.id }

    context 'when user is authenticated' do
      it 'is allowed to see active users' do
        get "/api/v1/users/#{active_user_id}", headers: auth_headers
        expect(response).to have_http_status(:ok)
      end

      it 'is not allowed to see blocked users' do
        get "/api/v1/users/#{blocked_user_id}", headers: auth_headers
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is not authenticated' do
      it 'is not allowed to see active users' do
        get "/api/v1/users/#{active_user_id}"
        expect(response).to have_http_status(:unauthorized)
      end

      it 'is not allowed to see blocked users' do
        get "/api/v1/users/#{blocked_user_id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/users/:id/profile' do
    let(:request_profile) { JSON.parse(response.body).to_json }
    let(:json_profile) { ProfileSerializer.new(active_user.profile).to_json }
    let(:active_user) { active_users.sample }
    let(:blocked_user) { blocked_users.sample }

    context 'when user is authenticated' do
      it 'is allowed to see profile of active users' do
        get "/api/v1/users/#{active_user.id}/profile", headers: auth_headers
        expect(response).to have_http_status(:ok)
      end

      it 'shows profile of specified user' do
        get "/api/v1/users/#{active_user.id}/profile", headers: auth_headers
        expect(request_profile).to eql json_profile
      end

      it 'is not allowed to see profile of blocked users' do
        get "/api/v1/users/#{blocked_user.id}/profile", headers: auth_headers
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user is not authenticated' do
      it 'is not allowed to see active users' do
        get "/api/v1/users/#{active_user.id}"
        expect(response).to have_http_status(:unauthorized)
      end

      it 'is not allowed to see blocked users' do
        get "/api/v1/users/#{blocked_user.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
