class VotesController < ApplicationController
  include VotingGuard

  def update
    poll = Poll.find(params[:poll_id])
    try_voting_for(poll)
    redirect_to hashed_poll_path(poll.hashed_id)
  end

  private

  def vote_for_question(poll, question_id)
    ActiveRecord::Base.transaction do
      question = poll.questions.find(question_id)
      question.vote!
      question.save
      mark_as_voted_for(poll)
    end
  end

  def try_voting_for(poll)
    return if voted_for?(poll)

    if poll.require_login && !user_signed_in?
      flash[:alert] = 'Logging in is required before taking part in this poll'
      return
    end

    vote_for_question(poll, params[:id])
  end
end
