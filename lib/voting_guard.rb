module VotingGuard
  def voted_for?(poll)
    return true if voting_cookie_include?(poll.id)
    return poll.voted_by_user?(current_user) if poll.require_login
    false
  end

  def mark_as_voted_for(poll)
    return if voted_for?(poll)

    cookies.signed[:voted_for] = "#{poll.id},#{cookies.signed[:voted_for]}"
    if poll.require_login
      poll.users << current_user
      poll.save
    end
  end

  def voted_for_cookie
    cookies.signed[:voted_for] ||= ''
  end

  def voting_cookie_include?(poll_id)
    voted_for_cookie.split(',').include?(poll_id.to_s)
  end
end
