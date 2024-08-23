class AlbumsController < ApplicationController
  def new
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.new
  end

  def show
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.find(params[:id])
  end

  def index
    @profile = current_user.profiles.find(params[:profile_id])
    @albums = @profile.albums.order(created_at: :desc)
  end

  def create
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.new(album_params)

    if @album.save
      flash[:success] = "アルバムを登録しました"
      redirect_to profile_albums_path(@album.profile_id)
    else
      flash[:danger] = "登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def album_params
    params.require(:album).permit(:date, :title, :diary, images:[])
  end
end
