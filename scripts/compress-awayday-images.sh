#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-assets/awayday}"
MAX_WIDTH="${MAX_WIDTH:-1600}"
JPEG_QUALITY="${JPEG_QUALITY:-82}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "No image directory found: $TARGET_DIR"
  exit 0
fi

compress_with_magick() {
  local file="$1"
  local tmp="${file%.*}.compressed.${file##*.}"

  magick "$file" -auto-orient -resize "${MAX_WIDTH}x${MAX_WIDTH}>" -strip -quality "$JPEG_QUALITY" "$tmp"
  mv "$tmp" "$file"
  echo "Compressed $file"
}

compress_with_sips() {
  local file="$1"

  sips -Z "$MAX_WIDTH" "$file" >/dev/null
  case "${file##*.}" in
    jpg|JPG|jpeg|JPEG)
      sips -s formatOptions "$JPEG_QUALITY" "$file" >/dev/null
      ;;
  esac
  echo "Compressed $file"
}

if command -v magick >/dev/null 2>&1; then
  COMPRESSOR="magick"
elif command -v sips >/dev/null 2>&1; then
  COMPRESSOR="sips"
else
  echo "No supported image compressor found. Install ImageMagick or run this on macOS with sips available." >&2
  exit 1
fi

while IFS= read -r -d '' file; do
  if [ "$COMPRESSOR" = "magick" ]; then
    compress_with_magick "$file"
  else
    compress_with_sips "$file"
  fi
done < <(find "$TARGET_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0)
