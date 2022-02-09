# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'posts', type: :request do
  let(:current_user) { create :user }
  let(:auth_headers) { current_user.create_new_auth_token }

  describe 'GET /api/v1/posts' do
    context 'when authenticated user' do
      before { get '/api/v1/posts', headers: auth_headers }

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
      before { get '/api/v1/posts' }

      it 'has http status 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/posts/:id' do
    let(:post) { create :post }

    before { get "/api/v1/posts/#{post.id}", headers: auth_headers }

    context 'when user is authenticated' do
      it 'returns a post by id' do
        expect(response.body).to eq PostSerializer.new(post).to_json
      end

      it 'has http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get public post' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get "/api/v1/posts/#{post.id}" }

      context 'when post is public' do
        it 'has http status 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when post is private' do
        before do
          post.update(status: 'private')
        end

        it 'is not allowed to show this Post' do
          expect { get "/api/v1/posts/#{post.id}" }.to raise_error(Pundit::NotAuthorizedError, 'not allowed to show? this Post')
        end
      end
    end
  end

  describe 'PUT /api/v1/posts/:id' do
    describe 'update post' do
      subject(:post) { build :post }

      let(:post_params) do
        {
          body: Faker::Lorem.sentences(number: 4)
        }
      end

      context 'when it is owned by user' do
        before do
          post.update(user_id: current_user.id)
          put "/api/v1/posts/#{post.id}", params: post_params, headers: auth_headers
          post.reload
        end

        context 'when user is authenticated' do
          it 'is allowed to modify his own post' do
            expect(response).not_to have_http_status(:unauthorized)
          end

          it 'has http status 200' do
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when user is not authenticated' do
          before do
            put "/api/v1/posts/#{post.id}", params: post_params
            post.reload
          end

          it 'has http status 401' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      context 'when it is not owned by user' do
        let(:post) { create :post }

        it 'is not allowed to modify post' do
          expect { put "/api/v1/posts/#{post.id}", params: post_params, headers: auth_headers }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:new_post) { build :post }
    let(:post_params) do
      {
        body: Faker::Lorem.sentences(number: 4),
        user_id: current_user.id
      }
    end

    before { post '/api/v1/posts', params: post_params, headers: auth_headers }

    before(context) { post '/api/v1/posts', params: post_params }

    it 'has correct content-type' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    context 'when user is authenticated' do
      before { get '/api/v1/posts', headers: auth_headers }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to create post' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authenticated' do
      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/posts/:id/add_tag' do
    describe 'add tag to post' do
      let(:current_user_post) { FactoryBot.create(:post, user_id: current_user.id) }
      let(:tag) { FactoryBot.create(:tag) }

      before { post "/api/v1/posts/#{current_user_post.id}/add_tag", params: { name: tag.name }, headers: auth_headers }

      context 'when user is authenticated' do
        it 'creates post tag' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        context 'with post that is not current user\'s post' do
          let(:not_current_user_post) { FactoryBot.create(:post) }
          let(:tag) { FactoryBot.create(:tag) }

          it 'can\'t create post tag' do
            # rubocop:disable Layout/LineLength
            expect { post "/api/v1/posts/#{not_current_user_post.id}/add_tag", params: { name: tag.name }, headers: auth_headers }.to raise_error(Pundit::NotAuthorizedError)
            # rubocop:enable Layout/LineLength
          end
        end
      end

      context 'when user is not authenticated' do
        before { post "/api/v1/posts/#{current_user_post.id}/add_tag", params: { name: tag.name } }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE /api/v1/posts/:post_id/remove_tag/:id' do
    describe 'delete tag from post' do
      let(:current_user_post) { create :post, user: current_user }
      let(:tag) { FactoryBot.create(:tag) }

      before { delete "/api/v1/posts/#{current_user_post.id}/remove_tag/#{tag.id}", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns no content' do
          expect(response).to have_http_status(:no_content)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        context 'with post that is not current user\'s post' do
          let(:not_current_user_post) { FactoryBot.create(:post) }

          it 'can\'t delete post tag' do
            # rubocop:disable Layout/LineLength
            expect { delete "/api/v1/posts/#{not_current_user_post.id}/remove_tag/#{tag.id}", headers: auth_headers }.to raise_error(Pundit::NotAuthorizedError)
            # rubocop:enable Layout/LineLength
          end
        end
      end

      context 'when user is not authenticated' do
        before { delete "/api/v1/posts/#{current_user_post.id}/remove_tag/#{tag.id}" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
