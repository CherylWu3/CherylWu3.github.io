#!/bin/sh
# Rebuild the HTML blog beside the existing static pages. Nothing is uploaded.
set -eu
website_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if command -v quarto >/dev/null 2>&1; then
  quarto_bin=$(command -v quarto)
elif [ -x "$HOME/Applications/quarto/bin/quarto" ]; then
  quarto_bin="$HOME/Applications/quarto/bin/quarto"
else
  printf '%s\n' 'Quarto is required: https://quarto.org/docs/get-started/' >&2
  exit 1
fi

# Keep publishing output separate from the live preview, which includes drafts.
"$quarto_bin" render "$website_dir/_blog" --output-dir _publish
# Only blog/ is generated. A full sync removes posts that were deleted or renamed.
mkdir -p "$website_dir/blog"
rsync -a --delete "$website_dir/_blog/_publish/" "$website_dir/blog/"
printf '%s\n' 'Blog HTML is ready in blog/. Nothing has been uploaded.'
