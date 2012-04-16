task :cron => :environment do
  ContentsController.daily_tweet
    puts "done."
  ContentsController.rolling and puts "Roll." if Time.now.strftime("%a") == "Sat"
  end

