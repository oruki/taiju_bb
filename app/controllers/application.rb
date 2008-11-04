# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Added 2008.06.10 same line should be commentouted in session controller.rb  
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  
 #2008.08.13 臨時的措置
 #2008.09.25 config.action_controller.session_store = :p_store..environment.rb changing session store
 
 # protect_from_forgery # :secret => '40b0b1c56754c3ccb700784344b04f48'
 #protect_from_forgery  :secret => '40b0b1c56754c3ccb700784344b04f48'
  def test
    @test=params[:flag]
  end
  

  private

  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice]= "ログインして下さい(auth)"
      redirect_to(:controller => 'sessions', :action => 'new')
    end
  end

end

#2008.08.04 'if self'added  check needed to work?
class Date
  def age(calcDay = Time.now)
    (calcDay.strftime("%Y%m%d").to_i-self.strftime("%Y%m%d").to_i)/10000 if self
  end
end

class Time
  def dif_time(on)
    (self.sec.to_i - on.sec.to_i)/3600.to_i
  end
end