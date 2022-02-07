# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Messages', type: :request do
  let(:current_user) { create :user }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:conversation) { create :conversation, users: [current_user, create(:user)] }
  let(:message_params) do
    {
      text: Faker::Lorem.sentence,
      conversation_id: conversation.id,
      user_id: current_user.id
    }
  end

  describe 'POST api/v1/messages' do
    context 'when user is authenticated' do
      before do
        post '/api/v1/messages', params: message_params, headers: auth_headers
      end

      context 'when user is a member of conversation' do
        it 'is allowed to create message if user is a member of conversation' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'when user is not a member of conversation' do
        let(:conversation) { create :conversation, :with_multiple_users }

        it 'is not allowed to create message' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when user is not authenticated' do
      before do
        post '/api/v1/messages', params: message_params
      end

      it 'is not allowed to create message' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PUT (PATCH) api/v1/messages' do
    subject(:message) { create :message, conversation: conversation }

    context 'when user is authenticated' do
      context 'when message belongs to user' do
        before do
          message.update(user: current_user)
          put "/api/v1/messages/#{message.id}", params: message_params, headers: auth_headers
        end

        it 'is allowed to update message' do
          expect(response).to have_http_status(:ok)
        end
      end

      context "when message doesn't belong to user" do
        before do
          put "/api/v1/messages/#{message.id}", params: message_params, headers: auth_headers
        end

        it 'is not allowed to update message' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when user is not authenticated' do
      before do
        put "/api/v1/messages/#{message.id}", params: message_params
      end

      it 'is not allowed to update message' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE api/v1/messages' do
    subject(:message) { create :message, conversation: conversation }

    context 'when user is authenticated' do
      context 'when message belongs to user' do
        before do
          message.update(user: current_user)
          delete "/api/v1/messages/#{message.id}", params: message_params, headers: auth_headers
        end

        it 'is allowed to delete message' do
          expect(response).to have_http_status(:no_content)
        end
      end

      context "when message doesn't belong to user" do
        before do
          delete "/api/v1/messages/#{message.id}", params: message_params, headers: auth_headers
        end

        it 'is not allowed to delete message' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when user is not authenticated' do
      before do
        delete "/api/v1/messages/#{message.id}", params: message_params
      end

      it 'is not allowed to delete message' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
