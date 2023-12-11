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

# Select only the Zip files for a certain period range
start_date = "202203"
end_date = "202302"

year = int(start_date[:4])
month = int(start_date[4:])
dates = []

while True:
    date_str = f"{year}{month:02}"
    dates.append(date_str+"-divvy-tripdata.zip")
    if date_str == end_date:
        break
    month += 1
    if month > 12:
        year += 1
        month = 1

# loop through each object and print its key
for content in soup.find_all('Contents'):
    key = content.find('Key').text
    if key and key in dates:
       file_abs = f"{url}/{key}"
       print(f"Downloading ... {file_abs}")
       
       # Download the file to the download directory      
       with open(os.path.join(download_dir, key), "wb") as f:
          response = requests.get(file_abs)
          f.write(response.content)
