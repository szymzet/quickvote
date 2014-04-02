module ApplicationHelper
  include VotingGuard

  def already_voted?(poll)
    voted_for?(poll.id)
  end
end
