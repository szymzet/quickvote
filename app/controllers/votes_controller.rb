class VotesController < ApplicationController
  include VotingGuard

  def update
    poll = Poll.find(params[:poll_id])
    vote_for_question(poll, params[:id])
    redirect_to hashed_poll_path(poll.hashed_id)
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
