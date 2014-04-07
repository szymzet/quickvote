module VotingGuard
  def voted_for?(poll)
    return true if voted_for_cookie.split(',').include?(poll.id.to_s)
    return poll.users.include?(current_user) if poll.require_login
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
end
