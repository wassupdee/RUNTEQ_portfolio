crumb :root do
  link "<span class='link'>Top</span>".html_safe, root_path
end

crumb :introduction do |id|
  if current_page?(introduction_path(1))
    link "<span class='font-bold text-lg'>イントロ</span>".html_safe, introduction_path(1)
  else
    link "<span class='link'>イントロ</span>".html_safe, introduction_path(1)
  end
  parent :root
end

crumb :question_1 do |question|
  current_question_id = params[:id].to_i
  if question.number == current_question_id
    link "<span class='font-bold text-lg'>質問#{question.number}</span>".html_safe, question_path(question.number)
  else
    link "<span class='link'>質問#{question.number}</span>".html_safe, question_path(question.number)
  end
  parent :introduction
end

crumb :question_2 do |question|
  parent_question = Question.find_by(number: question.number - 1)

  current_question_id = params[:id].to_i
  if question.number == current_question_id
    link "<span class='font-bold text-lg'>質問#{question.number}</span>".html_safe, question_path(question.number)
  else
    link "<span class='link'>質問#{question.number}</span>".html_safe, question_path(question.number)
  end
  parent :question_1, parent_question
end

crumb :question_3 do |question|
  parent_question = Question.find_by(number: question.number - 1)

  current_question_id = params[:id].to_i
  if question.number == current_question_id
    link "<span class='font-bold text-lg'>質問#{question.number}</span>".html_safe, question_path(question.number)
  else
    link "<span class='link'>質問#{question.number}</span>".html_safe, question_path(question.number)
  end
  parent :question_2, parent_question
end

crumb :ai_message do |question|
  link "<span class='font-bold text-lg'>AI提案文</span>".html_safe, ai_message_path
  parent :question_3, question
end
