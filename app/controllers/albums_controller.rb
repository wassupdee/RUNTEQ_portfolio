class AlbumsController < ApplicationController
  def new
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.new
  end

  def show
  end

  def index
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  # def profile_params
  #   params.require(:).permit(:)
  # end
end
