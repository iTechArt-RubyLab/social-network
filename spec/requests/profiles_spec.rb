# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Profiles', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }

  describe 'GET /api/v1/profiles' do
    context 'when authenticated user' do
      before { get '/api/v1/profiles', headers: auth_headers }

      it 'returns result' do
        expect(JSON.parse(response.body)).not_to eq []
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get list of profiles' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get '/api/v1/profiles' }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/profiles/:id' do
    let(:profile) { FactoryBot.create(:profile) }

    before { get "/api/v1/profiles/#{profile.id}", headers: auth_headers }

    context 'when authenticated user' do
      it 'returns a profile by id' do
        expect(response.body).to eq ProfileSerializer.new(profile).to_json
      end

      it 'have http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is allowed to get public profile' do
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when user is not authenticated' do
      before { get "/api/v1/profiles/#{profile.id}" }

      it 'have http status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/profiles/:id' do
    describe 'modify profile' do
      subject(:profile_data) { FactoryBot.build(:profile) }

      let(:profile_params) do
        { surname: profile_data.surname,
          name: profile_data.name,
          patronymic: profile_data.patronymic,
          birthday: profile_data.birthday,
          phone: profile_data.phone,
          about: profile_data.about }
      end

      context 'when it is owned by user' do
        let(:profile) { current_user.profile }

        before do
          put "/api/v1/profiles/#{profile.id}", params: profile_params, headers: auth_headers
          profile.reload
        end

        context 'when authenticated user' do
          it 'have http status 200' do
            expect(response).to have_http_status(:ok)
          end

          it 'updates the surname of the profile' do
            expect(profile.surname).to eq(profile_data.surname)
          end

          it 'updates the name of the profile' do
            expect(profile.name).to eq(profile_data.name)
          end

          it 'updates the phone of the profile' do
            expect(profile.phone).to eq(profile_data.phone)
          end

          it 'returns http success' do
            expect(response).to have_http_status(:success)
          end

          it 'is allowed to modify his own profile' do
            expect(response).not_to have_http_status(:unauthorized)
          end
        end

        context 'when user is not authenticated' do
          before do
            put "/api/v1/profiles/#{profile.id}", params: profile_params
            profile.reload
          end

          it 'have http status 401' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      context 'when it is not owned by user' do
        let(:profile) { FactoryBot.create(:profile) }

        it 'is not allowed to modify not his own profile' do
          expect { put "/api/v1/profiles/#{profile.id}", params: profile_params, headers: auth_headers }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe 'POST /api/v1/profiles' do
    let(:profile) { FactoryBot.create(:profile) }

    describe 'create profile' do
      subject(:profile_data) { FactoryBot.build(:profile) }

      let(:profile_params) do
        { surname: profile_data.surname,
          name: profile_data.name,
          patronymic: profile_data.patronymic,
          birthday: profile_data.birthday,
          phone: profile_data.phone,
          about: profile_data.about,
          user_id: current_user.id }
      end

      before { post '/api/v1/profiles', params: profile_params, headers: auth_headers }

      it 'has correct content-type' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      context 'when authenticated user' do
        it 'creates profile' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'is allowed to create profile' do
          expect(response).not_to have_http_status(:unauthorized)
        end
      end

      context 'when user is not authenticated' do
        before { post '/api/v1/profiles', params: profile_params }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'POST /api/v1/profiles/:id/add_tag' do
    describe 'add tag to profile' do
      let(:current_user_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
      let(:tag) { FactoryBot.create(:tag) }

      before { post "/api/v1/profiles/#{current_user_profile.id}/add_tag", params: { name: tag.name }, headers: auth_headers }

      context 'when user is authenticated' do
        it 'creates profile tag' do
          expect(response).to have_http_status(:created)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        context 'with profile that is not current user\'s profile' do
          let(:not_current_user_profile) { FactoryBot.create(:profile) }
          let(:tag) { FactoryBot.create(:tag) }

          before { post "/api/v1/profiles/#{not_current_user_profile.id}/add_tag", params: { name: tag.name }, headers: auth_headers }

          it 'can\'t create profile tag' do
            expect(response).to have_http_status(:forbidden)
          end
        end
      end

      context 'when user is not authenticated' do
        before { post "/api/v1/profiles/#{current_user_profile.id}/add_tag", params: { name: tag.name } }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE /api/v1/profiles/:profile_id/remove_tag/:name' do
    describe 'delete tag from profile' do
      let(:current_user_profile) { create :profile, user: current_user }
      let(:tag) { FactoryBot.create(:tag) }

      before { delete "/api/v1/profiles/#{current_user_profile.id}/remove_tag/#{tag.name}", headers: auth_headers }

      context 'when user is authenticated' do
        it 'returns no content' do
          expect(response).to have_http_status(:no_content)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        context 'with profile that is not current user\'s profile' do
          let(:not_current_user_profile) { FactoryBot.create(:profile) }

          before { delete "/api/v1/profiles/#{not_current_user_profile.id}/remove_tag/#{tag.name}", headers: auth_headers }

          it 'can\'t delete profile tag' do
            expect(response).to have_http_status(:forbidden)
          end
        end
      end

      context 'when user is not authenticated' do
        before { delete "/api/v1/profiles/#{current_user_profile.id}/remove_tag/#{tag.name}" }

        it 'have http status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
