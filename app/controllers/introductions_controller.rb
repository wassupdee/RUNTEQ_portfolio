class IntroductionsController < ApplicationController
  def show
    @page_number = params[:id]
  end
end