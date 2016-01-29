class Dashboard::BaseController < ApplicationController
  layout 'dashboard/dashboard'
  
  
  def index
    tipster = Tipster.all
    ids = Tipster.leaderboard.revrange(0, -1).map!(&:to_i)
    @tipsters = tipster.index_by(&:id).values_at(*ids)
    @activities = PublicActivity::Activity.where(owner_id: current_tipster.id).first
  end
  
end