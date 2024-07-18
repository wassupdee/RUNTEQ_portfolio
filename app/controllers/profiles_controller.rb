class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
    @profile.events.build(name: '誕生日')
    @profile.events.build(name: '大切な日')
  end

  def create
    @profile = current_user.profiles.new(profile_params)

    if @profile.save
      flash[:success] = '連絡先を登録しました'
      redirect_to root_path # profile_path(@profile)
    else
      flash[:danger] = '連絡先を登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :furigana, :phone, :email, :line_name, :birthplace, :address, events_attributes: [:name, :date])
  end
end
