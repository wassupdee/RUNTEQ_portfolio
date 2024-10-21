require "rails_helper"

RSpec.describe "line_setting_page", type: :system do
  include LoginMacros

  let(:user) { create(:user) }

  before do
    login_as(user)
    visit line_qr_code_path
  end

  it "LINE公式アカウントIDが表示されること" do
    expect(page).to have_content("@589vljjq")
  end

  it "LINEログインリンクが表示されること" do
    find("a[href='#{auth_at_provider_path(provider: :line)}']").click
    expect(page).to have_current_path(%r{https://access\.line\.me/}, url: true)
  end
end
