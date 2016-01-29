class Tdashboard::TipstersController < Tdashboard::BaseController
  
  def show
  end
  
  
  def view_notifications
    current_tipster.unviewed_notifications.update_all(viewed: true)
    render json: current_tipster.unviewed_notifications.count
  end
  
end