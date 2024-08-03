class IntroductionsController < ApplicationController
  skip_before_action :require_login

  def show
    @page_number = params[:id]
  end
end
