class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def create
    poll = poll_from_params
    if poll.save
      return valid_poll(poll)
    end
    validation_error(poll)
  end

  def show
    @poll = Poll.find_by_hashed_id(params[:id_hash])
  end

  private

  def poll_params
    params.require(:poll).permit(:title, :require_login)
  end

  def poll_from_params
    poll = Poll.new(poll_params)
    poll.questions_from_string(params[:questions_string])
    poll
  end

  def validation_error(poll)
    flash[:alert] = poll.errors.full_messages.to_sentence
    @poll = poll
    redirect_to new_poll_path
  end

  def valid_poll(poll)
    flash[:notice] = {
        msg: "You can share this poll with others by using unique address: ",
        url: "#{hashed_poll_url(poll.hashed_id)}"
      }
    redirect_to hashed_poll_path(poll.hashed_id)
  end
end
