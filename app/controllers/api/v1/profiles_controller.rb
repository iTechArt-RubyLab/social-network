class API::V1::ProfilesController < ActionController::API
  before_action :set_profile, only: %i[show update]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
    render json: serialize_profiles, status: :ok
  end

  # GET /profiles/:id or /profiles/:id.json
  def show
    render json: serialize_profile, status: :ok 
  end

  # PUT /profiles/:id or /profiles/:id.json
  def update
    if profile_params.blank?
      render :json => { :error => "There was no profile data passed in so your profile could not be saved." },
             :status => :unprocessable_entity
    else
      if @profile.update(profile_params)
        render json: true, status: :ok 
      else
        render json: @profile.errors, status: :unprocessable_entity
      end
    end
  end

  # POST /profiles or /profiles.json
  def create
    if profile_params.blank?
      render :json => { :error => "There was no profile data passed in so your profile could not be saved." },
             :status => :unprocessable_entity
    else
      @profile = Profile.new(profile_params)
      if @profile.save
        render json: @profile, status: :created
      else
        render json: @profile.errors, status: :unprocessable_entity 
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def serialize_profile
    ProfileSerializer.new(@profile).to_json
  end

  def serialize_profiles
    @profiles.map{ |profile| ProfileSerializer.new(profile)}.to_json
  end

  def profile_params
    params.permit(
      :surname, :name, :patronymic, :birthday, :phone, :about, :user_id
    )
  end

  def authorize_profile!
    authorize(@profile || Profile)
  end
end
