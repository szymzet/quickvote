class VotesController < ApplicationController
  def update
    poll = Poll.find(params[:poll_id])
    vote_for_question(poll, params[:id])
    redirect_to hashed_poll_path(poll.hashed_id)
  end

  private

  def vote_for_question(poll, question_id)
    return if voted_for?(poll)
    question = poll.questions.find(question_id)
    question.vote!
    question.save
    mark_as_voted_for(poll)
  end

  def voted_for?(poll)
    (cookies.signed[:voted_for] ||= '').split(',').include?(poll.id.to_s)
  end

  def mark_as_voted_for(poll)
    if cookies.signed[:voted_for].blank?
      cookies.signed[:voted_for] = poll.id.to_s
    else
      cookies.signed[:voted_for] = "#{cookies.signed[:voted_for]},#{poll.id}"
    end
  end
end
