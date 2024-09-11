require "net/http"
require "uri"
require "json"
require "csv"

class GeminiRequestHandler
  GEMINI_API_KEY = File.read('api_gemini.key').strip
  MODEL_ID = 'gemini-1.5-flash-latest'
  FILENAME = "output.csv"

  def initialize
    @comment_arr = []
  end

  def parse_csv_to_array
    CSV.foreach(FILENAME) do |row|
      begin
        @comment_arr << row
      rescue CSV::MalformedCSVError => e
        puts "Skipping malformed line: #{e.message}"
      end
    end
  end

  def gemini_uri
    URI("https://generativelanguage.googleapis.com/v1beta/models/#{MODEL_ID}:generateContent?key=#{GEMINI_API_KEY}")
  end

  def build_request
    request = Net::HTTP::Post.new(gemini_uri.path + "?key=#{GEMINI_API_KEY}", { 'Content-Type' => 'application/json' })
    request.body = request_payload.to_json
    request
  end

  def request_payload
    {
      "system_instruction" => {
        "parts" => {
          "text" => "The contents being entered are a selection of comments from a YouTube video. Provide a short description of the overall feel of the video"
        }
      },
      "contents" => {
        "parts" => {
          "text" => "#{@comment_arr}"
        }
      },
      "safety_settings" => safety_settings
    }
  end

  def safety_settings
    [
        {
          "category" => "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold" => "BLOCK_NONE"
        },
        {
          "category" => "HARM_CATEGORY_HATE_SPEECH",
          "threshold" => "BLOCK_NONE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_NONE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_NONE"
        }
      ]
  end

  def get_gemini_response
    http = Net::HTTP.new(gemini_uri.host, gemini_uri.port)
    http.use_ssl = (gemini_uri.scheme == "https")
    response = http.request(build_request)
    handle_response(response)
  end

  def handle_response(response)
    parsed_data = JSON.parse(response.body)
    text = parsed_data["candidates"][0]["content"]["parts"][0]["text"]
    puts text
  end
end