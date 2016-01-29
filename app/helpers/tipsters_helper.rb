module TipstersHelper
  
  def render_custom_activity(activity)
    render 'activities/' + activity.key.gsub('.', '/'), activity: activity
  end
  
  def render_feed_activity(activity)
    render 'public_activity/' + activity.key.gsub('.', '/'), activity: activity
  end
  
end
