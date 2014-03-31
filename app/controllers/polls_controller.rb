class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def create
    poll = Poll.new(poll_params)
    poll.questions_from_string(params[:questions_string])
    poll.save
    redirect_to poll
  end

  def show
    @poll = Poll.find(params[:id])
  end

  private

  def poll_params
    params.require(:poll).permit(:title)
  end
end
