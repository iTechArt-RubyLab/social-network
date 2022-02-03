require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /api/v1/profiles" do
    before { get '/api/v1/profiles' }

    it 'returns profiles' do
      expect(JSON.parse(response.body)).to eq []
    end

    it 'have http status 200' do
      expect(response).to have_http_status(:ok)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/profiles/:id' do
    let(:profile) { FactoryBot.create(:profile) }

    before { get "/api/v1/profiles/#{profile.id}" }

    it 'returns a profile by id' do
      expect(response.body).to eq ProfileSerializer.new(profile).to_json
    end

    it 'have http status 200' do
      expect(response).to have_http_status(:ok)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /api/v1/profiles/:id' do
    let(:profile) { FactoryBot.create(:profile) }

    describe 'modify profile' do
      subject(:profile_data) { FactoryBot.build(:profile) }

      before do
        put "/api/v1/profiles/#{profile.id}", params: { surname: profile_data.surname,
                                                        name: profile_data.name,
                                                        patronymic: profile_data.patronymic,
                                                        birthday: profile_data.birthday,
                                                        phone: profile_data.phone,
                                                        about: profile_data.about }
        profile.reload
      end

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
    
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /api/v1/profiles' do
    let(:profile) { FactoryBot.create(:profile) }
    let(:user) { FactoryBot.create(:user) }

    describe 'create profile' do
      subject(:profile_data) { FactoryBot.build(:profile) }

      before do
        headers = { 'ACCEPT' => 'application/json; charset=utf-8' }
        post '/api/v1/profiles', params: { surname: profile_data.surname,
                                           name: profile_data.name,
                                           patronymic: profile_data.patronymic,
                                           birthday: profile_data.birthday,
                                           phone: profile_data.phone,
                                           about: profile_data.about,
                                           user_id: user.id }, headers: headers
      end

      it 'has correct content-type' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'creates profile' do
        expect(response).to have_http_status(:created)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
