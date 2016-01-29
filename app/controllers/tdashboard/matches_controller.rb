class Tdashboard::MatchesController < Tdashboard::BaseController
  before_action :set_betslip
  before_action :set_slip
  
  def index
    @league = League.find(params[:league_id])
    @matches = @league.matches.havent_start
  end
  
  def show
    @match = Match.find(params[:id])
  end
  
  def todaygame
    @leagues = League.includes(matches: [:odds]).where("odds_type_id = ?","1").references(matches: [:odds]).order(:name)
    @pick = current_slip.picks.new
    @slip = current_slip
    @picks_count = @slip.picks.count
    @countries = League.select(:country).distinct.order('country ASC')
  end
  
  private
  
  def set_betslip
    @betslip = Order.new
  end
  
  def set_slip
    @slip = current_slip
  end
  
  
end