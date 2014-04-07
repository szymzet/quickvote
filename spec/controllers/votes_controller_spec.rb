require 'spec_helper'

describe VotesController do
  describe '#update' do
    it 'marks poll as voted even when not logged in' do
      poll = Poll.create!(id: 13, title: 'title')
      Question.create!(name: 'something', id: 5, poll_id: poll.id)
      controller.stub(:mark_as_voted_for)
      allow(controller).to receive(:user_signed_in?) { false }

      put :update, poll_id: 13, id: 5

      expect(controller).to have_received(:mark_as_voted_for).with(poll)
      expect(Poll.find(13).users).to be_empty
    end

    it 'saves info about voting when login required' do
      poll = Poll.create!(id: 13, title: 'title', require_login: true)
      Question.create!(name: 'something', id: 5, poll_id: poll.id)
      user = User.create!(id: 7, email: 'someone@gmail.com')
      allow(controller).to receive(:user_signed_in?) { true }
      allow(controller).to receive(:current_user) { user }

      put :update, poll_id: 13, id: 5

      expect(Poll.find(13).users).to include(user)
      expect(Question.find(5).votes).to eq(1)
    end

    it 'prevents multiple votes from the same account' do
      poll = Poll.create!(id: 13, title: 'title', require_login: true)
      Question.create!(name: 'something', id: 5, poll_id: poll.id, votes: 2)
      user = User.create!(id: 7, email: 'someone@gmail.com')
      poll.users << user
      poll.save
      allow(controller).to receive(:user_signed_in?) { true }
      allow(controller).to receive(:current_user) { user }

      put :update, poll_id: 13, id: 5

      expect(Poll.find(13).users).to include(user)
      expect(Question.find(5).votes).to eq(2)
    end
  end
end
