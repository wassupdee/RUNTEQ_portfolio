crumb :root do
  link "Top", root_path
end

crumb :question_1 do |question|
  link "質問#{question.number}", question_path(question.number)
  parent :root
end

crumb :question_2 do |question|
  parent_question = Question.find_by(number: question.number - 1)
  link "質問#{question.number}", question_path(question.number)
  parent :question_1, parent_question
end

crumb :question_3 do |question|
  parent_question = Question.find_by(number: question.number - 1)
  link "質問#{question.number}", question_path(question.number)
  parent :question_2, parent_question
end

crumb :ai_message do |question|
  link "AI提案文", ai_message_path
  parent :question_3, question
end
