module Forkful
  module SocialSite
    def self.setup social_site
      "Forkful::SocialSites::#{social_site.slug.capitalize}".constantize
    end

    def self.can_lookup? social_site
      begin
        "Forkful::SocialSites::#{social_site.slug.capitalize}".constantize
        return true
      rescue
        return false
      end
    end
  end
end
