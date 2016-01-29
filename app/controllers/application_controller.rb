class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  private
  
  def current_slip
    if tipster_signed_in?
      if session[:slip_id]
        @current_slip ||= current_tipster.slips.find(session[:slip_id])
        if @current_slip.expired?
          @current_slip.destroy
          session[:slip_id] = nil
        end
      end
      if session[:slip_id].nil?
        @current_slip = current_tipster.slips.create!
        session[:slip_id] ||= @current_slip.id
      end
    end
    @current_slip
  end
  
  
end
