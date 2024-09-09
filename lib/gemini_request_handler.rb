require "net/http"
require "uri"
require "json"
require "csv"

GEMINI_API_KEY = File.read('api_gemini.key').strip

MODEL_ID = 'gemini-1.5-flash-latest'

FILENAME = "output.csv"

comment_arr = []

CSV.foreach(FILENAME) do |row|
  begin
    comment_arr << row
  rescue CSV::MalformedCSVError => e
    puts "Skipping malformed line: #{e.message}"
  end
end

uri = URI("https://generativelanguage.googleapis.com/v1beta/models/#{MODEL_ID}:generateContent?key=#{GEMINI_API_KEY}")

http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = (uri.scheme == "https")

request = Net::HTTP::Post.new(uri.path + "?key=#{GEMINI_API_KEY}", { 'Content-Type' => 'application/json' })

request.body = {
  "system_instruction" => {
    "parts" => {
      "text" => "The contents being entered are a selection of comments from a YouTube video. Provide a short description of the overall feel of the video"
    }
  },
  "contents" => {
    "parts" => {
      "text" => "#{comment_arr}"
    }
  },
  "safety_settings" => [
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
}.to_json

response = http.request(request)

puts "Response body: #{response.body}"
puts "Response status: #{response.code}"