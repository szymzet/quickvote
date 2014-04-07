require 'spec_helper'
require_relative '../helpers/poll_helper'

feature 'User authentication' do
  include PollHelper

  scenario 'User can log in and out with Google account' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :google_oauth2,
      { uid: '123456', info: { email: 'person@gmail.com' } })

    visit root_path
    click_on 'Log in using Google'

    expect(page).to have_no_content('Log in using Google')
    expect(page).to have_content('person@gmail.com')

    click_on 'log out'

    expect(page).to have_content('Log in using Google')
    expect(page).to have_no_content('person@gmail.com')
  end

  scenario 'Some polls require authentication to be voted for' do
    visit root_path
    create_poll('Another poll', 'one, two, three', require_login: true)

    click_on 'three'
    expect_vote_count('three', 0)
    expect(page).to have_content('Logging in is required before taking part in this poll')
  end
end
