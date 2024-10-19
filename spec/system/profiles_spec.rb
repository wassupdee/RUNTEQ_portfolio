require "rails_helper"

RSpec.describe "profiles", type: :system do
  include LoginMacros
  include CreateProfileMacros
  let(:user) { create(:user) }

  before { login_as(user) }

  describe "PC画面" do
    before do
      page.driver.browser.manage.window.resize_to(1280, 900)
    end

    describe "連絡先作成" do
      context "フォームの入力値が正常" do
        it "連絡先の新規作成が成功する" do
          visit profiles_path
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録しました"
          expect(page).to have_current_path(profile_path(Profile.last))
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の新規作成が失敗する" do
          visit profiles_path
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録できませんでした"
        end
      end

      context "プロフィール画像が1MB以上の場合" do
        it "連絡先の新規作成が失敗する" do
          visit profiles_path
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/large_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録できませんでした"
        end
      end
    end





  #   describe "連絡先編集" do
  #     context "フォームの入力値が正常" do
  #       it "連絡先の編集が成功する" do
  #         create_profile
  #         visit profiles_path
  #         within("#pc-profiles") do
  #           find("#pc-edit-profile-#{Profile.last.id}").click
  #         end
  #         fill_in "名前", with: "鈴木次郎"
  #         fill_in "フリガナ", with: "スズキジロウ"
  #         fill_in "誕生日", with: "1997-2-3"
  #         fill_in "卒業記念日", with: "優勝記念日"
  #         find_all("input[type='date']")[1].set("2010-10-25")
  #         fill_in "電話番号", with: "111-1111-1111"
  #         fill_in "メールアドレス", with: "email_2@example.com"
  #         fill_in "住所", with: "東京都新宿区西新宿2-8-1"
  #         fill_in "LINEの名前", with: "すずき"
  #         select "３年前", from: "最後に連絡した日"
  #         fill_in "メモ", with: "メモテスト_2"
  #         attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
  #         click_button "登録する"
  #         expect(page).to have_content "連絡先を更新しました"
  #         expect(page).to have_current_path(profile_path(Profile.last))
  #       end
  #     end

  #     context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
  #       it "連絡先の新規作成が失敗する" do
  #         visit profiles_path
  #         within("#pc-profiles") do
  #           click_button "連絡先を作成"
  #         end
  #         fill_in "名前", with: "山田太郎"
  #         fill_in "フリガナ", with: "ヤマダタロウ"
  #         fill_in "誕生日", with: "2000-2-3"
  #         fill_in "大切な日", with: "2020-10-4"
  #         fill_in "電話番号", with: "000-0000-0000"
  #         fill_in "メールアドレス", with: "email@example.com"
  #         fill_in "住所", with: "東京都新宿区西新宿2-8-1"
  #         fill_in "LINEの名前", with: "やまだ"
  #         select "１年前", from: "最後に連絡した日"
  #         fill_in "メモ", with: "メモテスト"
  #         attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
  #         click_button "登録する"
  #         expect(page).to have_content "連絡先を登録できませんでした"
  #       end
  #     end

  #     context "プロフィール画像が1MB以上の場合" do
  #       it "連絡先の新規作成が失敗する" do
  #         visit profiles_path
  #         within("#pc-profiles") do
  #           click_button "連絡先を作成"
  #         end
  #         fill_in "名前", with: "山田太郎"
  #         fill_in "フリガナ", with: "ヤマダタロウ"
  #         fill_in "誕生日", with: "2000-2-3"
  #         fill_in "大切な日", with: "2020-10-4"
  #         fill_in "電話番号", with: "000-0000-0000"
  #         fill_in "メールアドレス", with: "email@example.com"
  #         fill_in "住所", with: "東京都新宿区西新宿2-8-1"
  #         fill_in "LINEの名前", with: "やまだ"
  #         select "１年前", from: "最後に連絡した日"
  #         fill_in "メモ", with: "メモテスト"
  #         attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/large_image.jpg")
  #         click_button "登録する"
  #         expect(page).to have_content "連絡先を登録できませんでした"
  #       end
  #     end
  #   end
  # end

  describe "スマホ画面" do
    before do
      page.driver.browser.manage.window.resize_to(1279, 900)
    end

    describe "連絡先作成" do
      context "フォームの入力値が正常" do
        it "連絡先の新規作成が成功する" do
          visit profiles_path
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録しました"
          expect(page).to have_current_path(profile_path(Profile.last))
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の新規作成が失敗する" do
          visit profiles_path
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録できませんでした"
        end
      end

      context "プロフィール画像が1MB以上の場合" do
        it "連絡先の新規作成が失敗する" do
          visit profiles_path
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "2000-2-3"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2020-10-25")
          fill_in "電話番号", with: "000-0000-0000"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "住所", with: "東京都新宿区西新宿2-8-1"
          fill_in "LINEの名前", with: "やまだ"
          select "１年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/large_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を登録できませんでした"
        end
      end
    end
  end
end
