require "rails_helper"

RSpec.describe "ai_messages", type: :system do
  before do
    Rails.application.load_seed
  end

  context "回答が正常の場合" do
    it "メッセージを提案すること" do
      # OpenAI Clientのモックをつくる
      openai_client_mock = double("OpenAI client")

      # OpenAI Clientからchatメソッドが呼び出され、レスポンスを設定。レスポンスからdigメソッドが呼び出されるのでハッシュにする
      allow(openai_client_mock).to receive(:chat).and_return(
        {
          "choices" => [
            { "message" => { "content" => "AIが提案したメッセージです！" } }
          ]
        }
      )

      # 実際に回答する
      visit introduction_path(1)
      click_button "質問にすすむ"
      choose "answer[question1]_friend"
      click_button "次へ"
      check "answer[question2]_life"
      click_button "次へ"
      choose "answer[question3]_male"
      expect(page).to have_current_path(question_path(3))

      session = {
        question1: "friend",
        question2: "['life']",
        question3: "male"
      }

      # 本物のサービスインスタンスをつくり、仮のセッションを渡す
      ai_suggest_service = AiSuggestionService.new(session)

      # oepnai_clientが呼び出されたとき、APIのインスタンスではなく、mockを渡す
      allow(ai_suggest_service).to receive(:openai_client).and_return(openai_client_mock)

      # 本物のサービスインスタンスからメソッドを呼び出す。ただし、実際に呼び出されるのはmock
      expect(ai_suggest_service.suggest).to eq("AIが提案したメッセージです！")
    end
  end

  context "質問1の回答が未選択の場合" do
    it "質問2に遷移できない" do
      visit introduction_path(1)
      click_button "質問にすすむ"
      click_button "次へ"
      expect(page).to have_current_path(question_path(1))
    end
  end

  context "質問2の回答が未選択の場合" do
    it "質問3に遷移できない" do
      visit introduction_path(1)
      click_button "質問にすすむ"
      choose "answer[question1]_friend"
      click_button "次へ"
      click_button "次へ"
      alert = page.driver.browser.switch_to.alert
      expect(alert.text).to eq("少なくとも1つ選択してください。")
    end
  end

  context "質問3の回答が未選択の場合" do
    it "AIメッセージ提案ページに遷移できない" do
      visit introduction_path(1)
      click_button "質問にすすむ"
      choose "answer[question1]_friend"
      click_button "次へ"
      check "answer[question2]_life"
      click_button "次へ"
      click_button "次へ"
      expect(page).to have_current_path(question_path(3))
    end
  end
end
