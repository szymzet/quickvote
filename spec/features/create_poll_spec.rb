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

    votes = all('#poll .question .votes')
    expect(votes.count).to eq 2
    votes.each do |vote_count|
      expect(vote_count.text).to eq '0'
    end
  end
end
