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

user = User.create!(
  email: "seed@example.com",
  name: "Seed User",
  password: "password123",
  password_confirmation: "password123",
  notification_enabled: true
)

10.times do |n|
  profile = user.profiles.create!(
      name: Faker::Name.unique.name,
      furigana: "てすと",
      phone: Faker::PhoneNumber.unique.phone_number,
      email: Faker::Internet.unique.email,
      line_name: "てすと",
      address: "東京都中央区123-456",
      last_contacted: Profile.last_contacteds.keys.sample,
      note: "久しぶりに連絡を取った！元気そうでよかった！"
    )
  profile.events.create!(
    name: "誕生日",
    date: Faker::Date.backward(days: 30),
    notification_timing: [0,1,3,7,14,30,60].sample,
    notification_enabled: true
  )
  profile.events.create!(
    name: "大切な日",
    date: Faker::Date.backward(days: 30),
    notification_timing: [0,1,3,7,14,30,60].sample,
    notification_enabled: true
  )
end