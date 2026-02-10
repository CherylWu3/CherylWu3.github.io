#!/bin/bash
# Double-click this file on Mac to update the photography page
# after adding new photos to the photos/ folder.

cd "$(dirname "$0")"

echo "const PHOTOS = [" > photos-data.js
first=true
for f in photos/*.{jpg,jpeg,png,gif,webp,JPG,JPEG,PNG}; do
  [ -f "$f" ] || continue
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> photos-data.js
  fi
  # URL-encode spaces in filenames
  encoded=$(echo "$f" | sed 's/ /%20/g')
  filename=$(basename "$f")
  caption="${filename%.*}"
  echo "  {\"src\": \"$encoded\", \"alt\": \"$caption\"}" >> photos-data.js
done
echo "" >> photos-data.js
echo "];" >> photos-data.js

count=$(grep -c '"src"' photos-data.js)
echo "Done! photos-data.js updated with $count photo(s)."
