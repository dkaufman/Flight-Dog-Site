class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
    @r = InitR()
    x = [1,2,3,4]
    @result = @r.mean(x)
    
  end

  def contact
    @title = "Contact"
  end

end
