# youtube-comments-scraper

## Description

This terminal-based application allows you to scrape top-level comments from YouTube videos and export them to a CSV file. It also uses Gemini Flash 1.5 to analyze the sentiment of the comments.

## Features

- Export YouTube video comments to a CSV file
- Easily modify the target video by updating the video ID
- Integrate Gemini Flash 1.5 for comment sentiment analysis

## Installation

1. Clone the repository
    ```bash
    git clone https://github.com/toby-d-parsons/youtube-comments-scraper.git
    ```
2. Navigate to the project directory
    ```bash
    cd youtube-comments-scraper
    ```
3. Set up API keys:
    - Create the files api_youtube.key and api_gemini.key.
    - Paste your YouTube Data API key into api_youtube.key.
    - Paste your Gemini API key into api_gemini.key.

    _For more information, see how to setup a [Google Cloud API key](https://developers.google.com/youtube/v3/getting-started) and a [Gemini API key](https://ai.google.dev/gemini-api/docs/quickstart?lang=rest)_
    
4. Update the `VIDEO_ID` value within `lib/youtube_comments_scraper.rb` to the URL of your choice

5. Run the YouTube comments scraper:
    ```bash
    ruby lib/youtube_comments_scraper.rb
    ```

6. The comments will be saved in `export.csv`, with each comment on a new line

7. Run the Gemini request handler to analyze the sentiment:
    ```bash
    ruby lib/gemini_request_handler.rb
    ```

8. The sentiment analysis of the comments will be printed in the console.