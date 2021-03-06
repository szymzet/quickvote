require 'spec_helper'
require 'uri'
require_relative '../helpers/poll_helper'

feature 'Create a poll' do
  include PollHelper

  before(:each) do
    visit root_path
  end

  scenario 'User can create a new poll' do
    create_poll('What for dinner?', 'pizza, burger, pork chops')

    expect_poll_title('What for dinner?')
    expect_poll_questions(['pizza', 'burger', 'pork chops'])
  end

  scenario 'New poll questions have zero votes' do
    create_poll('Choose', 'first, second')

    expect_vote_count('first', 0)
    expect_vote_count('second', 0)
  end

  scenario 'New poll has a unique hash in URL' do
    create_poll('Choose', 'first, second, third')

    expect(URI(current_url).path).to match(/^\/[a-zA-Z0-9]{8}$/)
  end

  scenario 'User is prompted with poll URL for sharing' do
    create_poll('Awesome poll', 'awesome, lame, weak')

    expect(page).to have_content("You can share this poll with others by using unique address:")
    expect(page.find("input.copyable").value).to eq(current_url)
  end

  scenario 'Poll has too short title' do
    create_poll('A', 'first, second')

    expect(page).to have_content('Title is too short')
  end
end
