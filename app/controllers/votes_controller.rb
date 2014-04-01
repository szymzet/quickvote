class VotesController < ApplicationController
  def update
    poll = Poll.find(params[:poll_id])
    vote_for_question(poll, params[:id])
    redirect_to hashed_poll_path(poll.hashed_id)
  end

  private

  def vote_for_question(poll, question_id)
    question = poll.questions.find(question_id)
    question.vote!
    question.save
  end
end
