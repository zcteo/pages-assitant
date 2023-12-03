#!/bin/bash

enddate=$(cat enddate)

dir="bing-imgs/${enddate:0:4}/${enddate:4:2}/"

mkdir -p "$dir"

mv img.jpg "$dir/${enddate}.jpg"

json=$(curl 'https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1')

url="https://cn.bing.com"$(echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["url"])')

echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["enddate"])' > enddate

wget "$url" -O img.jpg
