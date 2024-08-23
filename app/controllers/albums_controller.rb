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
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.new(album_params)

    if @album.save
      flash[:success] = "アルバムを登録しました"
      redirect_to profile_albums_path(@profile)
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
