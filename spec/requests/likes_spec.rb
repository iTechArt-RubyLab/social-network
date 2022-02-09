# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'Likes', type: :request do
  let(:current_user) { create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:valid_post) { create(:post) }

  describe 'POST /api/v1/likes' do
    describe 'create like' do
      before { post '/api/v1/likes', params: { likeable_id: valid_post.id, likeable_type: 'Post' }, headers: auth_headers }

      it 'has correct content-type' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      context 'when user is authenticated' do
        it 'creates like' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'DELETE /api/v1/likes/:id' do
    describe 'delete like' do
      let(:like) { create(:like, user: current_user) }

      before { delete "/api/v1/likes/#{like.id}", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
