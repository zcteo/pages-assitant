import os
import re
import requests
from bs4 import BeautifulSoup

url = 'https://bafybeih65no5dklpqfe346wyeiak6wzemv5d7z2ya7nssdgwdz4xrmdu6i.ipfs.dweb.link/'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
script_str = soup.find_all('script')[1].string
cards = soup.find_all('article', class_='card')
if not os.path.exists('data'):
    os.mkdir('data')
if not os.path.exists('data/plugins'):
    os.mkdir('data/plugins')
for card in cards:
    name = card.h1.string
    key = card["data-sequence"]
    version = card.button["data-version"]
    pattern = '"' + key + '":{"[^"]*":"([^"]*)"}'
    result = re.search(pattern, script_str)
    name = name.replace(' ', '')
    pattern = '[^0-9^A-Z^a-z]'
    name = re.sub(pattern, "", name)
    if card.find_all('div', class_='icon icon-plugin'):
        name = 'plugins/' + name
    with open('./data/' + name + '.txt', 'w') as f:
        f.write(result.group(1))
