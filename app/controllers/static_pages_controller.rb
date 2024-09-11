class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top; end

  def line_qr_code; end

  def line_policy; end

  def privacy_policy; end

  def terms; end
end
