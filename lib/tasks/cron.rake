namespace :cron do
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do    
    Scrape.new.save
    Scrape.delay.initiate()    
end
end