class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
    @profile.events.build(name: '誕生日')
    @profile.events.build(name: '大切な日')
  end

  def create
    binding.pry
    @profile = current_user.profiles.new(profile_params.except(:events))

    if @profile.save
      events_params.each do |event_param|
        @profile.events.create(event_param)
      end
      flash[:success] = '連絡先を登録しました'
      redirect_to root_path # profile_path(@profile)
    else
      flash[:danger] = '連絡先を登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :furigana, :phone, :email, :line_name, :birthplace, :address, events: [:name, :date])
  end

  def events_params
    params.require(:profile).fetch(:events, {}).values.map do |event|
      event.permit(:name, :date)
    end
  end
end
