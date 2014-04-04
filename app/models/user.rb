class User < ActiveRecord::Base
  devise :omniauthable

  def self.find_for_google_oauth2(omniauth)
    search_hash = { email: omniauth['info']['email'],
                    provider: omniauth['provider'],
                    uid: omniauth['uid'] }
    where(search_hash).first || User.create!(search_hash)
  end
end
