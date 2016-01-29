module ActsAsFollower
  module Followable
    module InstanceMethods
    
      def recent_following
        Follow.recent(2.weeks.ago).where(followable_id: self.id)
      end
    
    end
  end
end