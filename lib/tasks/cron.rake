desc "This task is called by the Heroku cron add-on"
task :cron => :environment do  
  if Time.now.hour == 19 && Time.now.minute == 24 # run at 4:00am
    Scrape.new.save
    Scrape.delay.initiate()
  end
end