require "net/http"
require "uri"
require "json"

GEMINI_API_KEY = File.read('api_gemini.key').strip

MODEL_ID = 'gemini-1.5-flash-latest'

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
      "text" => "INSERT LIST OF COMMENTS"
    }
  }
}.to_json

response = http.request(request)

puts "Response body: #{response.body}"
puts "Response status: #{response.code}"