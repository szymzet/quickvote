require 'spec_helper'
require_relative '../helpers/poll_helper'

feature 'Vote on poll' do
  include PollHelper

  scenario 'User can vote on a poll question' do
    visit root_path
    create_poll('Choose', 'first, second')
    click_on('second')
    within('#poll') do
      first_votes = find('.question', text: 'first').find('.votes')
      second_votes = find('.question', text: 'second').find('.votes')
      expect(first_votes.text).to eq '0'
      expect(second_votes.text).to eq '1'
    end
  end
end
