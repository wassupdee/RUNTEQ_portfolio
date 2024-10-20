require "rails_helper"

RSpec.describe "profiles", type: :system do
  include LoginMacros
  include CreateProfileMacros
  let(:user) { create(:user) }

  before { login_as(user) }
  describe "PC画面" do
    describe "連絡先作成" do
      before do
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1280, 900)
      end

      context "フォームの入力値が正常" do
        it "連絡先の新規作成が成功する" do
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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
          expect(page).to have_content("山田太郎")
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の新規作成が失敗する" do
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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
          within("#pc-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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

    describe "連絡先編集" do
      before do
        create_profile_one
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1280, 900)
      end

      context "フォームの入力値が正常" do
        it "連絡先の更新が成功する" do
          within("#pc-profiles") do
            find("#pc-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新しました"
          expect(page).to have_current_path(profile_path(Profile.last))
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の更新が失敗する" do
          within("#pc-profiles") do
            find("#pc-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新できませんでした"
        end
      end

      context "プロフィール画像が1MB以上の場合" do
        it "連絡先の更新が失敗する" do
          within("#pc-profiles") do
            find("#pc-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/large_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新できませんでした"
        end
      end
    end

    describe "連絡先削除" do
      before do
        create_profile_one
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1280, 900)
      end

      it "連絡先の削除が成功する" do
        within("#pc-profiles") do
          find("#pc-delete-profile-#{Profile.last.id}").click
        end
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).not_to have_css("#pc-profile-#{Profile.last.id}")
      end
    end

    describe "連絡先一覧" do
      before do
        create_profile_one
        create_profile_two
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1280, 900)
      end

      describe "連絡先" do
        it "作成した連絡先が一覧に表示されること" do
          within("#pc-profiles") do
            within("table") do
              expect(page).to have_content("山田太郎")
              expect(page).to have_content("佐藤一郎")
            end
          end
        end

        it "「最後に連絡した日」を一覧から変更できること" do
          within("#pc-profiles") do
            select "１ヵ月以内", from: "profile_last_contacted", match: :first
          end
          expect(page).to have_content("１ヵ月以内")
          expect(Profile.last.last_contacted).to eq("within_one_month")
        end

      end

      describe "検索" do
        it "名前で検索ができる" do
          within("#pc-profiles") do
            fill_in "名前", with: "佐藤"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end

        it "ふりがなで検索ができる" do
          within("#pc-profiles") do
            fill_in "ふりがな", with: "サトウ"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end

        it "グループでフィルタリングができる" do
          within("#pc-profiles") do
            select "グループ2", from: "q_group_id_eq"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end
      end

      describe "バナー" do
        it "今月イベントをもつprofilesの名前が表示されること" do
          within("#sticky-banner-pc") do
            expect(page).to have_content("佐藤")
          end
        end
        it "バナーを削除できること" do
          within("#sticky-banner-pc") do
            find("#close-banner-btn-pc").click
            expect(page).not_to have_css("#sticky-banner-pc")
          end
        end
      end
    end
  end

  describe "スマホ画面" do
    describe "連絡先作成" do
      before do
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1279, 900)
      end

      context "フォームの入力値が正常" do
        it "連絡先の新規作成が成功する" do
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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
          expect(page).to have_content("山田太郎")
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の新規作成が失敗する" do
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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
          within("#mobile-profiles") do
            click_button "連絡先を作成"
          end
          fill_in "名前", with: "山田太郎"
          fill_in "フリガナ", with: "ヤマダタロウ"
          fill_in "誕生日", with: "02-03-2003"
          fill_in "大切な日", with: "卒業記念日"
          find_all("input[type='date']")[1].set("2-5-2020")
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

    describe "連絡先編集" do
      before do
        create_profile_one
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1279, 900)
      end

      context "フォームの入力値が正常" do
        it "連絡先の更新が成功する" do
          within("#mobile-profiles") do
            find("#mobile-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新しました"
          expect(page).to have_current_path(profile_path(Profile.last))
        end
      end

      context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
        it "連絡先の更新が失敗する" do
          within("#mobile-profiles") do
            find("#mobile-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新できませんでした"
        end
      end

      context "プロフィール画像が1MB以上の場合" do
        it "連絡先の更新が失敗する" do
          within("#mobile-profiles") do
            find("#mobile-edit-profile-#{Profile.last.id}").click
          end
          fill_in "名前", with: "鈴木次郎"
          fill_in "フリガナ", with: "スズキジロウ"
          fill_in "誕生日", with: "02-03-2001"
          fill_in "卒業記念日", with: "優勝記念日"
          find_all("input[type='date']")[1].set("2-5-2019")
          fill_in "電話番号", with: "111-1111-1111"
          fill_in "メールアドレス", with: "email_2@example.com"
          fill_in "住所", with: "大阪府大阪市北区梅田3-1-1"
          fill_in "LINEの名前", with: "すずき"
          select "３年前", from: "最後に連絡した日"
          fill_in "メモ", with: "メモテスト_2"
          attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/large_image.jpg")
          click_button "登録する"
          expect(page).to have_content "連絡先を更新できませんでした"
        end
      end
    end

    describe "連絡先削除" do
      before do
        create_profile_one
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1279, 900)
      end

      it "連絡先の削除が成功する" do
        within("#mobile-profiles") do
          find("#mobile-delete-profile-#{Profile.last.id}").click
        end
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).not_to have_css("#mobile-profile-#{Profile.last.id}")
      end
    end

    describe "連絡先一覧" do
      before do
        create_profile_one
        create_profile_two
        visit profiles_path
        page.driver.browser.manage.window.resize_to(1279, 900)
      end

      describe "連絡先" do
        it "作成した連絡先が一覧に表示されること" do
          within("#mobile-profiles") do
            within("table") do
              expect(page).to have_content("山田太郎")
              expect(page).to have_content("佐藤一郎")
            end
          end
        end
      end

      describe "検索" do
        it "名前で検索ができる" do
          within("#mobile-profiles") do
            fill_in "名前", with: "佐藤"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end

        it "ふりがなで検索ができる" do
          within("#mobile-profiles") do
            fill_in "ふりがな", with: "サトウ"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end

        it "グループでフィルタリングができる" do
          within("#mobile-profiles") do
            select "グループ2", from: "q_group_id_eq"
            find("button[type='submit']").click
          end
          expect(page).to have_current_path(profiles_path)
          expect(page).to have_content("佐藤")
          expect(page).not_to have_content("山田")
        end
      end

      describe "バナー" do
        it "今月イベントをもつprofilesの名前が表示されること" do
          within("#sticky-banner-mb") do
            expect(page).to have_content("佐藤")
          end
        end

        it "バナーを削除できること" do
          within("#sticky-banner-mb") do
            find("#close-banner-btn-mb").click
            expect(page).not_to have_css("#sticky-banner-mb")
          end
        end
      end
    end
  end
end
