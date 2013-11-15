desc "This task is called by the Heroku scheduler add-on"
task :get_weekly_books => :environment do
  puts "Fetching this weeks New York Times Lists"
  Book.get_nyt_lists
  puts "DONE getting this weeks NYT lists"
  puts "Fetching newly added books from Amazon"
  Book.batch_amazon_attribs
  puts "DONE fetching Amazon book attribs"
end
