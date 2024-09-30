class ProfilesController < ApplicationController
  before_action :set_q, only: %i[index]
  before_action :set_profile_record, only: %i[edit update destroy]

  def new
    @profile = Profile.new
    @profile.events.build(name: "誕生日")
    @profile.events.build(name: "大切な日")
  end

  def show
    @profile = current_user.profiles.includes(:events).find(params[:id])
  end

  def index
    @profiles = @q.result(distinct: true).includes(:events)
    profiles_with_events = current_user.profiles.includes(:events)

    @profiles_birthdays_this_month = profiles_with_events.select(&:birthdays_this_month)
    @profiles_special_day_this_month = profiles_with_events.select(&:special_days_this_month)
  end

  def create
    @profile = current_user.profiles.new(profile_params.except(:group))
    @profile.group = Group.find(profile_params[:group][:id])
    profile_save
  end

  def edit; end

  def update
    @profile.group = Group.find(profile_params[:group][:id])
    if @profile.update(profile_params.except(:group))
      update_success
    else
      flash[:danger] = "連絡先を更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy!

    respond_to do |format|
      format.html { redirect_to profiles_path, status: :see_other }
      format.turbo_stream { render turbo_stream: turbo_stream.remove("profile_#{@profile.id}") }
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :name, :furigana, :phone, :email, :line_name, :address, :last_contacted, :note, group: %i[id], events_attributes: %i[name date id])
  end

  def update_success
    respond_to do |format|
      format.html do
        flash[:success] = "連絡先を更新しました"
        redirect_to profile_path(@profile)
      end
      format.turbo_stream
    end
  end

  def set_q
    @q = current_user.profiles.ransack(params[:q])
    @q.combinator = "or"
    @q.sorts = "name asc" if @q.sorts.empty?
  end

  def set_profile_record
    @profile = current_user.profiles.find(params[:id])
  end

  def profile_save
    if @profile.save
      flash[:success] = "連絡先を登録しました"
      redirect_to profile_path(@profile)
    else
      flash[:danger] = "連絡先を登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  end
end
