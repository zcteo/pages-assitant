#!/bin/bash

mv img.jpg "bing-imgs/$(cat startdate).jpg"

json=$(curl 'https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1')

url="https://cn.bing.com"$(echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["url"])')

echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["startdate"])' > startdate

wget "$url" -O img.jpg
