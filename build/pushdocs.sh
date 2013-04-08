#!/bin/bash
cd ~/Projects/kirojs-docs/
cp -r ../shihai/build/release/docs/ shihai
cd shihai
git add .
git commit -a -m "Updating docs"
git push origin gh-pages
