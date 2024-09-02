class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
    @profile.events.build(name: "誕生日")
    @profile.events.build(name: "大切な日")
  end

  def show
    @profile = current_user.profiles.includes(:events).find(params[:id])
  end

  def index
    @q = current_user.profiles.ransack(params[:q])
    @q.combinator = "or"
    @profiles = @q.result(distinct: true).includes(:events).order(created_at: :desc)
  end

  def create
    @profile = current_user.profiles.new(profile_params)

    if @profile.save
      flash[:success] = "連絡先を登録しました"
      redirect_to profile_path(@profile)
    else
      flash[:danger] = "連絡先を登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @profile = current_user.profiles.includes(:events).find(params[:id])
  end

  def update
    @profile = current_user.profiles.find(params[:id])
    if @profile.update(profile_params)
      flash[:success] = "連絡先を更新しました"
      redirect_to profile_path(@profile)
    else
      flash[:danger] = "連絡先を更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile = current_user.profiles.find(params[:id])
    @profile.destroy!

    respond_to do |format|
      format.html {
        redirect_to profiles_path, status: :see_other
      }
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove("profile_#{@profile.id}")
      }
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :name, :furigana, :phone, :email, :line_name, :birthplace, :address, :occupation, events_attributes: %i[name date id])
  end
end
