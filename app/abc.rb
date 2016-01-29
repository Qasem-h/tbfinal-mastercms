class Abc

def self.perform(order_id)
 order = Order.find(order_id)
 streak = order.user.selling_streak.value

 case streak
  when 3
  order.user.add_badge(5) unless user.badges.any? {|b| b.id == 5}
  when 5
  order.user.add_badge(6) unless user.badges.any? {|b| b.id == 6}
 end
end

end 