class Tdashboard::PicksController < ApplicationController
  def create
    @slip = current_slip
    match = Match.find(params[:match_id])
    odds = params[:odds]
    team = params[:team]
    bettype = params[:bettype]
    bet = params[:bet]
    total = params[:total]
    @pick = @slip.add_pick(match.id, odds, team, current_tipster, match.static_id, bettype, bet, total)
  
    respond_to do |format|
      if @pick.save
        @slip.update(expires_at: Time.now + 10.minutes)
        session[:counter] = nil
        format.html { redirect_to :back,
          notice: 'Pick was successfully created.'}
        format.js { @current_pick = @pick}
        format.json { render json: @pick,
          status: :created, location: @pick}
        else
          flash[:pick_error] = "Pick cannot be more than 6 per betslip"
          format.html { redirect_to :back }
          format.json { render json: @line_item.errors,
            status: :unprocessable_entity }
        end
      end
  end

  def update
    @slip = current_slip
    @pick = @slip.picks.find(params[:id])
    @pick.update_attributes(pick_params)
    @picks = @slip.picks
  end

  def destroy
    @slip = current_slip
    @pick = @slip.picks.find(params[:id])
    respond_to do |format|
      if @pick.destroy
        format.html { redirect_to :back,
          notice: 'Pick was successfully deleted.'}
        format.js
        format.json { render json: @pick,
          status: :delete, location: @pick}
        end
      end
    @picks = @slip.picks
  end
private
  def pick_params
    params.require(:pick).permit(:matchid, :odds, :match_id, :slip_id)
  end
  
end
