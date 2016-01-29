class BadgesWorker
  include Sidekiq::Worker
  
  sidekiq_options retry: false
  
  def perform(order_id)
    order = Order.find(order_id)
    tipster = order.tipster
    streak = tipster.winning_streak.value
    case streak
    when 3
      tipster.add_badge(5) unless tipster.badges.any? {|b| b.id == 5}
    when 5
      tipster.add_badge(6) unless tipster.badges.any? {|b| b.id == 6}
    when 7
      tipster.add_badge(7) unless tipster.badges.any? {|b| b.id == 7}
    when 10
      tipster.add_badge(8) unless tipster.badges.any? {|b| b.id == 8}
    when 15
      tipster.add_badge(9) unless tipster.badges.any? {|b| b.id == 9}
    when 20
      tipster.add_badge(10) unless tipster.badges.any? {|b| b.id == 10}
    end
  end
  
end