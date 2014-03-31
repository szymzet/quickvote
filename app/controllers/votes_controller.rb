class VotesController < ApplicationController
  def update
    poll = Poll.find(params[:poll_id])
    question = poll.questions.find(params[:id])
    question.vote!
    question.save
    redirect_to poll
  end
end
