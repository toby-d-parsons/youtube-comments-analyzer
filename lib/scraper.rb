require "httparty" 
require "json"

YOUTUBE_API_KEY = File.read('api_youtube.key').strip

VIDEO_ID = 'W3id8E34cRQ'

url = "https://www.googleapis.com/youtube/v3/commentThreads?key=#{YOUTUBE_API_KEY}&textFormat=plainText&part=snippet&videoId=#{VIDEO_ID}&maxResults=100"

response = HTTParty.get(url)

comments_data = JSON.parse(response.body)

FILENAME = "output.csv"

File.open(FILENAME, 'w') do |file|
  comments_data["items"].each do |item|
    comment_text = item["snippet"]["topLevelComment"]["snippet"]["textDisplay"]
                        .gsub(/\r?\n/, " ")
                        .gsub(/"/, "'")
                        .strip
    file.puts comment_text unless comment_text.match?(/\A\s*\z/)
  end
end

puts "Scraper initialized"