module VotingGuard
  def voted_for?(poll_id)
    voted_for_cookie.split(',').include?(poll_id.to_s)
  end

  def mark_as_voted_for(poll_id)
    return if voted_for?(poll_id)
    cookies.signed[:voted_for] = "#{poll_id},#{cookies.signed[:voted_for]}"
  end

  def voted_for_cookie
    cookies.signed[:voted_for] ||= ''
  end
end
