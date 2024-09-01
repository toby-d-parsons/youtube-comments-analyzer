# youtube-comments-scraper

## Description

This terminal-based application allows you to scrape high-level comments from individual YouTube videos

## Features

- High-level comments exported into a CSV file
- Easily amendable code to set your preferred video

## Installation

1. Clone the repository
    ```bash
    git clone https://github.com/toby-d-parsons/youtube-comments-scraper.git
    ```
2. Navigate into the project directory
    ```bash
    cd youtube-comments-scraper
    ```
3. Create a file 'api.key' and paste your Google Cloud API key

    _For more information on how to setup a Google Cloud API key please refer to Google's developer documentation [here](https://developers.google.com/youtube/v3/getting-started)_
    
4. Amend the `VIDEO_ID` value within `lib/scraper.rb` to the URL of your choice

5. Run the scraper:
    ```bash
    ruby lib/scraper.rb
    ```

6. Comments will be printed into the `export.csv` file with a newline between them