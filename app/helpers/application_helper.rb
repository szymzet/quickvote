module ApplicationHelper
  def already_voted?(poll)
    (cookies.signed[:voted_for] ||= '').split(',').include?(poll.id.to_s)
  end
end
