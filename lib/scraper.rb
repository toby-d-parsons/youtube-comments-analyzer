require "httparty" 
require "json"

YOUTUBE_API_KEY = File.read('api_youtube.key').strip

VIDEO_ID = 'dQw4w9WgXcQ'

url = "https://www.googleapis.com/youtube/v3/commentThreads?key=#{YOUTUBE_API_KEY}&textFormat=plainText&part=snippet&videoId=#{VIDEO_ID}&maxResults=100"

response = HTTParty.get(url)

comments_data = JSON.parse(response.body)

filename = "output.csv"

File.open(filename, 'w') do |file|
  comments_data["items"].each do |item|
    file.puts item["snippet"]["topLevelComment"]["snippet"]["textDisplay"].sub(/\n/, " ")
  end
end

puts "Scraper initialized"