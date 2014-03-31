require 'spec_helper'

feature 'View the homepage' do
  scenario 'User sees page title' do
    visit root_path
    expect(page).to have_css('h1', :text => 'Quickvote')
  end
end
