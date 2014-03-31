module PollHelper
  def expect_poll_question(question)
    expect(page).to have_css('#poll .question', text: question)
  end

  def expect_poll_questions(questions)
    questions.each { |question| expect_poll_question(question) }
  end

  def create_poll(title, questions)
    fill_in('Poll title', with: title)
    fill_in('questions_string', with: questions)
    click_button('Create poll')
  end

  def expect_poll_title(title)
    expect(page).to have_css('h2', text: title)
  end

  def expect_vote_count(name, expected_votes)
    votes = find('#poll .question', text: name).find('.votes')
    expect(votes.text.to_i).to eq expected_votes.to_i
  end
end
