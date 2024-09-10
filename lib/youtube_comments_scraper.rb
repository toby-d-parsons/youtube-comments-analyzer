require "httparty" 
require "json"

class YouTubeCommentsScraper
  YOUTUBE_API_KEY = File.read('api_youtube.key').strip
  FILENAME = "output.csv"

  def initialize(video_id)
    @video_id = video_id
  end

  def construct_url
    "https://www.googleapis.com/youtube/v3/commentThreads?key=#{YOUTUBE_API_KEY}&textFormat=plainText&part=snippet&videoId=#{@video_id}&maxResults=100"
  end

  def get_comments_thread
    response = HTTParty.get(construct_url)
    JSON.parse(response.body)
  end

  def export_to_csv(comments_thread)
    File.open(FILENAME, 'w') do |file|
      comments_thread["items"].each do |item|
        comment_text = item["snippet"]["topLevelComment"]["snippet"]["textDisplay"]
                            .gsub(/\r?\n/, " ")
                            .gsub(/"/, "'")
                            .strip
        file.puts comment_text unless comment_text.match?(/\A\s*\z/)
      end
    end
  end
end

scraper = YouTubeCommentsScraper.new('W3id8E34cRQ')
comments_thread = scraper.get_comments_thread
scraper.export_to_csv(comments_thread)

puts "Scraper initialized"