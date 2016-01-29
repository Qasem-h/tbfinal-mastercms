class Tdashboard::SlipsController < ApplicationController
  
  def new
    @betslip = Slip.new
  end
  
  def show
    @slip_picks = current_slip.picks
    @slip = current_slip
  end
  
  def destroy
    @slip = current_slip
    @slip.destroy
    session[:slip_id] = nil
    
    respond_to do |format|
      format.html { redirect_to matches_path,
        notice: 'Your betslip is currently empty' }
      format.json { head :no_content }
    end
  end
  
  def create
  end
  
  private
  
  def params_slip
    params.require(:slip).permit(:stake, :possible_winnings, :tipster_id, :account_id)
  end
  
end
