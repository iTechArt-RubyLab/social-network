# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'UserSubscriptions', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:subscription) { FactoryBot.create(:user) }

  describe 'POST /api/v1/user/:user_id/subscribe' do
    describe 'create user subscription' do
      before { post "/api/v1/users/#{subscription.id}/subscribe", headers: auth_headers }

      it 'has correct content-type' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      context 'when user is authenticated' do
        it 'creates user subscription' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        context 'with the same subscriber and subscription' do
          let(:subscription) { current_user }

          before { post "/api/v1/users/#{subscription.id}/subscribe", headers: auth_headers }

          it 'can\'t create user subscription' do
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      context 'when user is not authenticated' do
        before { post "/api/v1/users/#{subscription.id}/subscribe" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'POST /api/v1/user_subscriptions/:id' do
    describe 'delete user subscription' do
      before { post "/api/v1/users/#{subscription.id}/unsubscribe", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns no content' do
          expect(response).to have_http_status(:no_content)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when user is not authenticated' do
        before { post "/api/v1/users/#{subscription.id}/unsubscribe" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'GET /api/v1/users/:user_id/subscribers' do
    describe 'get user subscribers' do
      before { get "/api/v1/users/#{current_user.id}/subscribers", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns result' do
          expect(JSON.parse(response.body)).to be_empty
        end

        it 'has http status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'is allowed to get list of subscribers' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { get "/api/v1/users/#{current_user.id}/subscribers" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'GET /api/v1/users/:user_id/subscriptions' do
    describe 'get user subscriptions' do
      before { get "/api/v1/users/#{current_user.id}/subscriptions", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns result' do
          expect(JSON.parse(response.body)).to be_empty
        end

        it 'has http status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'is allowed to get list of subscriptions' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { get "/api/v1/users/#{current_user.id}/subscriptions" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
