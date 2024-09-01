class ImagesController < ApplicationController
  def destroy
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge

    render turbo_stream: [
      turbo_stream.remove("album_#{@image.record_id}-#{@image.id}"),
      turbo_stream.replace("album_hidden_fields", partial: "albums/hidden_fields", locals: { album: @image.record })
    ]
  end
end
