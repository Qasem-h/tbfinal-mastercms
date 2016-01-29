module ApplicationHelper
  
  def rank_for(name)
    Tipster.leaderboard.revrank(name) + 1
  end
  
  def gravatar_for(email, options = {})
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
  
  def bet_summary(user)
    array = []
    Order.where(tipster_id: user.id).where(handler: true).last(5).map do |order|
      array << {period: order.created_at.strftime("%Y-%m-%d") , stakes: order.stake, winnings: order.winnings}
    end
    array
  end
  
  
  
end
