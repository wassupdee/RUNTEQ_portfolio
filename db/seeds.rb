question1 = Question.find_or_create_by!(text: "メッセージを送りたい相手は？", number: "1")
question2 = Question.find_or_create_by!(text: "メッセージに含めたい内容は？", number: "2")
question3 = Question.find_or_create_by!(text: "あなたの性別を教えてください", number: "3")

answers_data = [
  { text: "友だち", value: "friend", number: "1", question: question1 },
  { text: "家族", value: "family", number: "2", question: question1 },
  { text: "仕事関係", value: "work", number: "3", question: question1 },
  { text: "ちょっとした知り合い", value: "acquaintance", number: "4", question: question1 },
  { text: "そのほか", value: "others", number: "5", question: question1 },

  { text: "最近どうしてる？", value: "life", number: "1", question: question2 },
  { text: "仕事は順調？", value: "job", number: "2", question: question2 },
  { text: "今どこに住んでいるの？", value: "place", number: "3", question: question2 },
  { text: "久しぶりに会いたい", value: "meet", number: "4", question: question2 },
  { text: "ご飯でもいこう", value: "eat", number: "5", question: question2 },
  { text: "遊びにいこう", value: "play", number: "6", question: question2 },

  { text: "男性", value: "male", number: "1", question: question3 },
  { text: "女性", value: "female", number: "2", question: question3 },
  { text: "そのほか", value: "other_gender", number: "3", question: question3 },
  { text: "答えたくない", value: "no_comment", number: "4", question: question3 },
]

answers_data.each do |answer_data|
  Answer.find_or_create_by!(answer_data)
end