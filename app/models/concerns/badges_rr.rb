module BadgesRr
  extend ActiveSupport::Concern
  
  included do
    after_create :badges_rr, if: :rr_exists?
  end
    
    def recovery_rate
     min_bal = tipster.accounts.where("balance=?", tipster.accounts.minimum(:balance)).first
     pre_maxb = tipster.accounts.where("created_at < ?", min_bal.created_at).maximum(:balance)
     aft_max = tipster.accounts.where("created_at > ?", min_bal.created_at).maximum(:balance)
     
     unless pre_maxb.nil? || aft_max.nil?
       (aft_max - min_bal.balance) / pre_maxb 
     end
     end
   
     def badges_rr
       case
       when recovery_rate.between?(0.2, 0.3)
         tipster.add_badge(17) unless tipster.badges.any? {|b| b.id == 17}
       when recovery_rate.between?(0.3, 0.4)
         tipster.add_badge(18) unless tipster.badges.any? {|b| b.id == 18}
       when recovery_rate.between?(0.4, 0.5)
         tipster.add_badge(19) unless tipster.badges.any? {|b| b.id == 19}
       when recovery_rate.between?(0.5, 0.6)
         tipster.add_badge(20) unless tipster.badges.any? {|b| b.id == 20}
       when recovery_rate.between?(0.6, 0.7)
         tipster.add_badge(21) unless tipster.badges.any? {|b| b.id == 21}
       when recovery_rate > 0.7
         tipster.add_badge(22) unless tipster.badges.any? {|b| b.id == 22}
       end
     end
   
     private
   
     def rr_exists?
       recovery_rate != nil && recovery_rate > 0.2
     end 
     
   end