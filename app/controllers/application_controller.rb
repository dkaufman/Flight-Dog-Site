class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def InitR
    @r = RSRuby.instance
    return @r
  end

end
