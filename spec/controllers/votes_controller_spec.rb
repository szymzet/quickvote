require 'spec_helper'

describe VotesController do
  describe '#update' do
    it 'marks poll as voted even when not logged in' do
      poll = create(:poll)
      allow(controller).to receive(:mark_as_voted_for)
      allow(controller).to receive(:user_signed_in?) { false }

      put :update, poll_id: poll.id, id: poll.questions.first.id

      expect(controller).to have_received(:mark_as_voted_for).with(poll)
      expect(poll.reload.users).to be_empty
    end

    it 'saves info about voting when login required' do
      poll = create(:authenticated_poll)
      user = create(:user)
      question = poll.questions.second
      allow(controller).to receive(:user_signed_in?) { true }
      allow(controller).to receive(:current_user) { user }

      put :update, poll_id: poll.id, id: question.id

      expect(poll.reload.users).to include(user)
      expect(question.reload.votes).to eq(1)
    end

    it 'prevents multiple votes from the same account' do
      user = create(:user)
      poll = build(:authenticated_poll)
      question = create(:question, name: 'xd', votes: 2)
      poll.users << user
      poll.questions << question
      poll.save
      allow(controller).to receive(:user_signed_in?) { true }
      allow(controller).to receive(:current_user) { user }

      put :update, poll_id: poll.id, id: question.id

      expect(poll.reload.users).to include(user)
      expect(question.reload.votes).to eq(2)
    end
  end
end
