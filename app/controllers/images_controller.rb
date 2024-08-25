class ImagesController < ApplicationController
  def destroy
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
  end
end
