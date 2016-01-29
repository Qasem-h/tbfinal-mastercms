class Dashboard::TipstersController < Dashboard::BaseController
  layout 'dashboard/dashboard'
  
  def index
    tipster = Tipster.all
    ids = Tipster.leaderboard.revrange(0, -1).map!(&:to_i)
    @tipsters = tipster.index_by(&:id).values_at(*ids)
  end
  
  def show
    @tipster = Tipster.find params[:id]
  end
  
  def follow
    @tipster = Tipster.find params[:id]
    current_user.follow(@tipster)
    current_user.create_activity action: 'follow', recipient: @tipster, owner: current_user
    redirect_to :back, flash: { notice: 'Tipster has been followed' }
  end
  
  def unfollow
    @tipster = Tipster.find params[:id]
    current_user.stop_following(@tipster)
    current_user.create_activity action: 'unfollow', recipient: @tipster, owner: current_user
    redirect_to :back, flash: { error: 'Tipster has been unfollowed' }
  end
  
  def mytipsters
    @tipsters = current_user.all_following
  end
  
end
