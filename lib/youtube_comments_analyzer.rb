require_relative 'youtube_comments_analyzer/gemini_request_handler.rb'
require_relative 'youtube_comments_analyzer/youtube_comments_scraper.rb'

module YoutubeCommentsAnalyzer
  def self.run(video_id)
    
    scraper = YouTubeCommentsScraper.new(video_id)
    comments_thread = scraper.get_comments_thread
    scraper.export_to_csv(comments_thread)

    puts "Scraper initialized"

    gemini_request_handler = GeminiRequestHandler.new
    gemini_request_handler.parse_csv_to_array
    gemini_request_handler.get_gemini_response
  end
end

app = YoutubeCommentsAnalyzer
app.run('W3id8E34cRQ')