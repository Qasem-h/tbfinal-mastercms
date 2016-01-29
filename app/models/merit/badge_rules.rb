# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods
    

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge 
       grant_on 'tipsters/registrations#create', badge: 'just-registered'

      # If it has 10 comments, grant commenter-10 badge
      grant_on 'tdashboard/orders#create', badge_id: 23, model_name: 'Order' do |order|
        order.tipster.orders.count > 20
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 24, model_name: 'Order' do |order|
        order.tipster.orders.count > 50
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 25, model_name: 'Order' do |order|
        order.tipster.orders.count > 100
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 26, model_name: 'Order' do |order|
        order.tipster.orders.count > 250
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 27, model_name: 'Order' do |order|
        order.tipster.orders.count > 500
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 28, model_name: 'Order' do |order|
        order.tipster.orders.count > 1000
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 34, model_name: 'Order' do |order|
        order.tipster.time_active.value == 10
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 35, model_name: 'Order' do |order|
        order.tipster.time_active.value == 30
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 36, model_name: 'Order' do |order|
        order.tipster.time_active.value == 60
      end
      
      grant_on 'tdashboard/orders#create', badge_id: 37, model_name: 'Order' do |order|
        order.tipster.time_active.value == 180
      end
      
      
      

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'tipsters/registrations#create', badge_id: 1,
      #   model_name: 'Tipster' do |user|
      #
      #   user.name.length > 4
      # end
    end
        
  end
end
