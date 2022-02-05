# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Tags', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }

  describe 'GET /api/v1/tags' do
    context 'when user is authenticated' do
      before { get '/api/v1/tags', headers: auth_headers }

      it 'returns result' do
        expect(JSON.parse(response.body)).to eq []
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get list of tags' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get '/api/v1/tags' }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/tags/:id' do
    let(:tag) { FactoryBot.create(:tag) }

    before { get "/api/v1/tags/#{tag.id}", headers: auth_headers }

    context 'when user is authenticated' do
      it 'returns a tag by id' do
        expect(response.body).to eq TagSerializer.new(tag).to_json
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get tag' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get "/api/v1/tags/#{tag.id}" }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/tags' do
    describe 'create tag' do
      subject(:tag_data) { FactoryBot.build(:tag) }

      let(:tag_params) { { name: tag_data.name } }

      before { post '/api/v1/tags', params: tag_params, headers: auth_headers }

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

        it 'is allowed to create tag' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { post '/api/v1/tags', params: tag_params }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'GET /api/v1/tags/:id/posts' do
    describe 'get tag posts' do
      let(:tag) { create :tag }

      before { get "/api/v1/tags/#{tag.id}/posts", headers: auth_headers }

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

        it 'is allowed to get list of posts' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { get "/api/v1/tags/#{tag.id}/posts" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
