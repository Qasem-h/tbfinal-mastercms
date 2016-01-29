class Tdashboard::OrdersController < Tdashboard::BaseController
  before_action :set_betslip
  before_action :set_slip
  before_action :slip_expired?, only: :create

  
  def index
     @orders = current_tipster.orders.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
  end
  
  
  def create

      @order = current_tipster.orders.new(params_order)
      @order.add_picks_from_slip(current_slip)

    
    respond_to do |format|
      if @order.save
        Slip.destroy(session[:slip_id])
        session[:slip_id] = nil
        flash[:notice] = "Betslip was successfully placed."
        @order.create_activity owner: current_tipster, key: "order.create", recipient: nil 
        format.html { redirect_to :back }
        format.json { render json: @order,
          status: :delete, location: @order}
      else
        flash[:pick_errors] = @order.errors.full_messages
        format.html { redirect_to :back}
      end
    end
  end
  
  private
  
  def params_order
    params.require(:order).permit(:stake, :winnings, :tipster_id, :possible_winnings)
  end
  
  private
  
  def set_betslip
    @betslip = Order.new
  end
  
  def set_slip
    @slip = current_slip
  end
  
  def slip_expired?
    if current_slip.picks.empty?
      flash[:notice] = "Your betslip has expired! Please submit bets within 10 minutes!"
      redirect_to :back
    end
  end
          
end
