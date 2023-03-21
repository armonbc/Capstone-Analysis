import requests
from bs4 import BeautifulSoup
import os

# URL of the page containing the table
url = "https://divvy-tripdata.s3.amazonaws.com"

# Directory to save the downloaded files
download_dir = "../original_zipfiles"

# Create the directory if it doesn't exist
if not os.path.exists(download_dir):
    os.makedirs(download_dir)

# Send a GET request to the URL and get the response
xml_response = requests.get(url)

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(xml_response.content, 'xml')

# loop through each object and print its key
for content in soup.find_all('Contents'):
    key = content.find('Key').text
    if key and key.endswith('.zip'):
       file_abs = f"{url}/{key}"
       print(f"Downloading ... {file_abs}")
       # Download the file to the download directory
      
       with open(os.path.join(download_dir, key), "wb") as f:
          response = requests.get(file_abs)
          f.write(response.content)
