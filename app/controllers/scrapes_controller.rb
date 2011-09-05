class ScrapesController < ApplicationController
  def create
    Scrape.new.save
    Scrape.delay.initiate()
  end
end