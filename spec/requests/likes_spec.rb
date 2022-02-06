# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:current_user) { create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:post) { create(:post) }


  describe 'POST /api/v1/likes' do
    describe 'create user subscription' do
      before { post '/api/v1/likes', params: { likeable_id: 12,likeable_type:'Post'}, headers: auth_headers }

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

      end

      context 'when user is not authenticated' do
        before { post '/api/v1/likes', params: { likeable: post } }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE /api/v1/likes/:id' do
    describe 'delete user like' do
      let(:like) { create(:like, user: current_user, likeable: post) }

      before { delete "/api/v1/likes/#{like.id}", headers: auth_headers }

      context 'when user is authenticated' do

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when user is not authenticated' do
        before { delete "/api/v1/likes/#{like.id}" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end