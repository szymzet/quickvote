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
end
