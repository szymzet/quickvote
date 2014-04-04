require 'spec_helper'

feature 'User authentication' do
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
end
