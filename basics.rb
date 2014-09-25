require 'sinatra'
require 'geocoder'
require 'timezone'

t = Time.now()

get '/' do
	"Hello World!"
	
end

get '/about' do
	"There is information here"
end

get '/hello/:name' do
	name_from_url = params[:name]
	"Hello, how do you do, #{name_from_url.downcase}?"
end

get '/form' do 

	erb:form
end

Timezone::Configure.begin do |c| 
  c.username = 'manitp' # get your username from http://www.geonames.org/login 
  # then go to http://www.geonames.org/manageaccount and click enable at the bottom of the page
end
post '/form' do
  city = params[:message]
  timezones = Timezone::Zone.names
  find_zone = timezones.find{|e| /#{city}/ =~ e}
  timezone = Timezone::Zone.new :zone => find_zone
  show_time = timezone.time Time.now
  show_time = show_time.to_s.split(' ')
  time = show_time[1]
  time = time.split(':')
  hours = time[0]
  minutes = time[1]

  if hours.to_i > 12
  	hours = hours.to_i - 12
  	checker = "PM"
  else
  	checker = "AM"
  end

  "<center><h3>The current time in #{city} is:</h3><br><br><h1>#{hours}:#{minutes}#{checker}</h1></center>"
 
end
