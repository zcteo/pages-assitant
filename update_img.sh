#!/bin/bash

enddate=$(cat enddate)

dir="bing-imgs/${enddate:0:4}/${enddate:4:2}/"

mkdir -p "$dir"

cp img.jpg "$dir/${enddate}.jpg"

cp json.json "$dir/${enddate}.json"

json=$(curl 'https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1')

url="https://cn.bing.com"$(echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["url"])')

echo "$json" | python3 -c 'import sys, json; print(json.load(sys.stdin)["images"][0]["enddate"])' > enddate

echo "$json" | python3 -c \
    'import sys, json; img = json.load(sys.stdin)["images"][0]; \
     ret = {"title": img["title"], "desc": img["copyright"]}; \
     print(json.dumps(ret, ensure_ascii=False))' > json.json

wget "$url" -O img.jpg
