module Badges
  extend ActiveSupport::Concern
  
  included do
    after_commit :badges
    after_update :badges_win_rate, if: :wr_60
    after_update :badges_unbeaten, if: :unbeaten_run
  end
  
  
    def badges
      BadgesWorker.perform_async(id)
    end
    
    def badges_win_rate
      wr = tipster.win_rate
      case
      when wr.between?(0.6, 0.7)
        tipster.add_badge(11) unless tipster.badges.any? {|b| b.id == 11}
      when wr.between?(0.7, 0.75)
        tipster.add_badge(12) unless tipster.badges.any? {|b| b.id == 12}
      when wr.between?(0.75, 0.8)
        tipster.add_badge(13) unless tipster.badges.any? {|b| b.id == 13}
      when wr.between?(0.8, 0.85)
        tipster.add_badge(14) unless tipster.badges.any? {|b| b.id == 14}
      when wr.between?(0.85, 0.9)
        tipster.add_badge(15) unless tipster.badges.any? {|b| b.id == 15}
      when wr > 0.9
        tipster.add_badge(16) unless tipster.badges.any? {|b| b.id == 16}
      end
    end
    
    def badges_unbeaten
      unbeaten = tipster.unbeaten.value
      case
      when unbeaten == 4
        tipster.add_badge(30) unless tipster.badges.any? {|b| b.id == 30}
      when unbeaten == 9
        tipster.add_badge(31) unless tipster.badges.any? {|b| b.id == 31}
      when unbeaten == 18
        tipster.add_badge(32) unless tipster.badges.any? {|b| b.id == 32}
      end
    end
        
    
    private
    
    def wr_60
      tipster.win_rate > 0.59 && tipster.orders.count > 20
    end
    
    def unbeaten_run
      tipster.unbeaten.value > 3
    end

  end
    