class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def create
    poll = Poll.new(poll_params)
    poll.questions_from_string(params[:questions_string])
    if poll.save
      redirect_to hashed_poll_path(poll.hashed_id)
    else
      flash[:alert] = poll.errors.full_messages.to_sentence
      @poll = poll
      redirect_to new_poll_path
    end
  end

  def show
    @poll = Poll.find_by_hashed_id(params[:id_hash])
  end

  private

  def poll_params
    params.require(:poll).permit(:title)
  end
end
