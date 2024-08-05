class Answer < ApplicationRecord
  belongs_to :question
  validates :value, uniqueness: true

  def self.save_answers_to_session(session, q_and_a)
    q_and_a.each do |key, value|
      session[key.to_sym] = value
    end
  end

  # キーをfirstで文字列に変換し、数字を取り出し、数値に変換
  # 1つしか要素がないので、firstや[0]は特定のインデックスを指定する意味合いは弱く、ただ取り出すだけに使っている
  def self.current_question_number(answer_params)
    answer_params.keys.first.match(/\d+/)[0].to_i
  end

  def self.last_question?(question_number)
    question_number == 3
  end
end
