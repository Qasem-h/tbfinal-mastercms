class Tdashboard::BaseController < ApplicationController
  layout 'tdashboard/tdashboard'
  before_action :authenticate_tipster!
  before_action :set_betslip, only: [:index]
  
  
  def index
    @betslip = Order.new
    @activities = PublicActivity::Activity.where(owner_id: Tipster.last.id).order('created_at DESC')
  end
  
  def view_notifications
    current_tipster.unviewed_notifications.update_all(viewed: true)
    render json: current_tipster.unviewed_notifications.count
  end
  
  
  private
  
  def set_betslip
    @slip = current_slip
  end
  
end