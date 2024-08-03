class EventsController < ApplicationController
  def index
    @profile = current_user.profiles.find(params[:profile_id])
    @form = Form::EventCollection.new(events: @profile.events)
  end

  def update_all
    @form = Form::EventCollection.new(event_params)
    if @form.update
      flash[:success] = "保存しました"
      redirect_to profile_events_path(@form.events.first.profile_id)
    else
      flash.now[:success] = "保存できませんでした"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:form_event_collection).permit(events_attributes: %i[id name date notification_timing notification_enabled profile_id])
  end
end
