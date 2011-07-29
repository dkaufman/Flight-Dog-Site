class SuggestionsController < ApplicationController
  def new
    @title = "Contact"
    @suggestion = Suggestion.new
  end


  def create
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      redirect_to root_path
    else
       @title = "Contact"
      render 'new'
    end
  end
end
