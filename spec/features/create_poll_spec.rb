require 'spec_helper'

feature 'Create a poll' do
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

  scenario 'User can create a new poll' do
    visit root_path
    create_poll('What for dinner?', 'pizza, burger, pork chops')

    expect_poll_title('What for dinner?')
    expect_poll_questions(['pizza', 'burger', 'pork chops'])
  end
end
