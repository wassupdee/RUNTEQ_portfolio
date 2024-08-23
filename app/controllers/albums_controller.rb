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
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.find(params[:id])
  end

  def update
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.find(params[:id])

    if @album.update(album_params.reject { |k| k["images"] })
      if album_params[:images].present?
        album_params[:images].each do |image|
          @album.images.attach(image)
        end
      end
      flash[:success] = "アルバムを更新しました"
      redirect_to profile_albums_path(@album.profile_id)
    else
      flash[:danger] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile = current_user.profiles.find(params[:profile_id])
    @album = @profile.albums.find(params[:id])
    @album.destroy!
    flash[:success] = "削除しました"
    redirect_to profile_albums_path(@album.profile_id), status: :see_other
  end

  private

  def album_params
    params.require(:album).permit(:date, :title, :diary, images:[])
  end
end
