# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'Conversations', type: :request do
  let(:current_user) { create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }

  describe 'GET /api/v1/conversations' do
    context 'when user is authenticated' do
      before { get '/api/v1/conversations', headers: auth_headers }

      it 'returns result' do
        expect(JSON.parse(response.body)).to eq []
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get list of conversations' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get '/api/v1/conversations' }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/conversations/:id' do
    let!(:conversation) { FactoryBot.create(:conversation) }

    before { get "/api/v1/conversations/#{conversation.id}", headers: auth_headers }

    context 'when user is authenticated' do
      it 'returns a profile by id' do
        expect(response.body).to eq ConversationSerializer.new(conversation).to_json
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get conversation' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get "/api/v1/conversations/#{conversation.id}" }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/conversations' do
    describe 'create conversation' do
      let(:conversation_params) { { name: Faker::Lorem.word } }

      before { post '/api/v1/conversations', params: conversation_params, headers: auth_headers }

      it 'has correct content-type' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      context 'when user is authenticated' do
        it 'creates tag' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'is allowed to create conversation' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { post '/api/v1/conversations', params: conversation_params }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE /api/v1/user_subscriptions/:id' do
    describe 'delete user conversation' do
      let!(:conversation) { FactoryBot.create(:conversation) }

      before { delete "/api/v1/conversations/#{conversation.id}", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when user is not authenticated' do
        before { delete "/api/v1/conversations/#{conversation.id}" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
