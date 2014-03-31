class VotesController < ApplicationController
  def update
    poll = Poll.find(params[:poll_id])
    vote_for_question(poll, params[:id])
    redirect_to poll
  end

  private

  def vote_for_question(poll, question_id)
    question = poll.questions.find(question_id)
    question.vote!
    question.save
  end
end
