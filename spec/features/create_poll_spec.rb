require 'spec_helper'

feature 'Create a poll' do
  def expect_poll_question(question)
    expect(page).to have_css('#poll .question', text: question)
  end

  scenario 'User can create a new poll' do
    visit root_path
    fill_in('Poll title', with: 'What for dinner?')
    fill_in('questions_string', with: 'pizza, burger, pork chops')
    click_button('Create poll')

    expect(page).to have_css('h2', text: 'What for dinner')
    expect_poll_question('pizza')
    expect_poll_question('burger')
    expect_poll_question('pork chops')
  end
end
