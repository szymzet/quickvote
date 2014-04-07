class VotesController < ApplicationController
  include VotingGuard

  def update
    poll = Poll.find(params[:poll_id])
    if !poll.require_login || user_signed_in?
      vote_for_question(poll, params[:id])
    else
      flash[:alert] = 'Logging in is required before taking part in this poll'
    end
    return redirect_to hashed_poll_path(poll.hashed_id)
  end

  private

  def vote_for_question(poll, question_id)
    return if voted_for?(poll.id)
    question = poll.questions.find(question_id)
    question.vote!
    question.save
    mark_as_voted_for(poll.id)
  end
end
