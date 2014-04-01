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
    expect_most_voted_question('first', 1)
  end

  scenario 'Do not show `most votes` when tied' do
    visit root_path
    create_poll('Choose', 'first, second, third')
    expect_no_most_voted_question
  end

  scenario 'User can vote only once on a poll question' do
    visit root_path
    create_poll('You like?', 'Yes, No')
    click_on('Yes')
    expect_vote_count('Yes', 1)
    click_on('Yes')
    expect_vote_count('Yes', 1)
    expect(page).to have_css('#already-voted', text: 'You have already voted')
  end

  scenario 'User can vote on multiple different polls' do
    visit root_path
    create_poll('First poll', 'A, B')
    click_on('B')
    expect_vote_count('B', 1)
    visit root_path
    create_poll('Second poll', 'C, D')
    click_on('C')
    expect_vote_count('C', 1)
  end
end
