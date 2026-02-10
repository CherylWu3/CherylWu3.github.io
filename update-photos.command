#!/bin/bash
# Double-click this file on Mac to update the photography page
# after adding new photos to the photos/ folder.
#
# To add notes to photos, edit photos-data.js afterwards and add
# a "note" field, e.g.:
#   {"src": "photos/fuji-1.jpg", "alt": "fuji-1", "note": "Mt. Fuji, Japan"}
#
# The script preserves any existing notes when regenerating.

cd "$(dirname "$0")"

# Save existing notes
old_data=""
if [ -f photos-data.js ]; then
  old_data=$(cat photos-data.js)
fi

get_note() {
  local src="$1"
  echo "$old_data" | grep "\"$src\"" | grep -o '"note": *"[^"]*"' | sed 's/"note": *"//;s/"$//' | head -1
}

echo "const PHOTOS = [" > photos-data.js
first=true
for f in photos/*; do
  case "$f" in
    *.jpg|*.jpeg|*.png|*.gif|*.webp|*.JPG|*.JPEG|*.PNG) ;;
    *) continue ;;
  esac
  [ -f "$f" ] || continue
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> photos-data.js
  fi
  encoded=$(echo "$f" | sed 's/ /%20/g')
  filename=$(basename "$f")
  caption="${filename%.*}"
  existing_note=$(get_note "$encoded")
  echo "  {\"src\": \"$encoded\", \"alt\": \"$caption\", \"note\": \"$existing_note\"}" >> photos-data.js
done
echo "" >> photos-data.js
echo "];" >> photos-data.js

count=$(grep -c '"src"' photos-data.js)
echo "Done! photos-data.js updated with $count photo(s)."
echo "Edit photos-data.js to add notes to your photos."
