module PollHelper
  def expect_poll_question(question)
    expect(page).to have_css('#poll .question', text: question)
  end

  def expect_poll_questions(questions)
    questions.each { |question| expect_poll_question(question) }
  end

  def create_poll(title, questions, options = {})
    fill_in('Poll title', with: title)
    fill_in('questions_string', with: questions)
    check('Only logged in users can vote') if options[:require_login]
    click_button('Create poll')
  end

  def expect_poll_title(title)
    expect(page).to have_css('h2', text: title)
  end

  def expect_vote_count(name, expected_votes)
    votes = find('#poll .question', text: name).find('.votes')
    expect(votes.text.to_i).to eq expected_votes.to_i
  end

  def expect_most_voted_question(name, expected_votes)
    most_voted_question = find('#most-votes')
    expect(most_voted_question.text).to match(/\b#{name}\b.*\b#{expected_votes}\b/)
  end

  def expect_no_most_voted_question
    expect(page).to have_no_selector('#most-votes')
  end

  def log_in_as(email)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :google_oauth2,
      { uid: '123456', info: { email: email } })

    click_on 'Log in using Google'
  end
end
