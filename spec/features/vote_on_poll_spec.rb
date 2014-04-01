require 'spec_helper'
require_relative '../helpers/poll_helper'

feature 'Vote on poll' do
  include PollHelper

  scenario 'User can vote on a poll question' do
    visit root_path
    create_poll('Choose', 'first, second')
    click_on('second')
    expect_vote_count('first', 0)
    expect_vote_count('second', 1)
  end

  scenario 'Show `most votes` when no tie' do
    visit root_path
    create_poll('Choose', 'first, second, third')
    click_on('first')
    click_on('first')
    expect_most_voted_question('first', 2)
  end

  scenario 'Do not show `most votes` when tied' do
    visit root_path
    create_poll('Choose', 'first, second, third')
    click_on('first')
    click_on('second')
    expect_no_most_voted_question
  end
end
