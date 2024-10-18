module LoginMacros
  def login_as(user)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    # ログイン処理が完了することを担保する
    expect(page).to have_current_path(root_path)
  end
end
