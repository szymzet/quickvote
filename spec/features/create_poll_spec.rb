require 'spec_helper'
require_relative '../helpers/poll_helper'

feature 'Create a poll' do
  include PollHelper

  scenario 'User can create a new poll' do
    visit root_path
    create_poll('What for dinner?', 'pizza, burger, pork chops')

    expect_poll_title('What for dinner?')
    expect_poll_questions(['pizza', 'burger', 'pork chops'])
  end

  scenario 'New poll questions have zero votes' do
    visit root_path
    create_poll('Choose', 'first, second')

    expect_vote_count('first', 0)
    expect_vote_count('second', 0)
  end
end
