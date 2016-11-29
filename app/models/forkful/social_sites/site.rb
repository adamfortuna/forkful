class Forkful::SocialSites::Site
  attr_accessor :remote_id

  def initialize remote_id
    @remote_id = remote_id
  end
end
