#!/bin/bash
git config user.name EricTeo
git config user.email zcteo.cn@gmail.com
git config core.autocrlf input
git add .
git commit -m "github actions update at $(date +%F\ %T\ %z)"
git push
