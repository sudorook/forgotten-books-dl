#! /bin/bash
set -euo pipefail

PREFIX="https://www.forgottenbooks.com/en"

function get_free_book_url {
  curl -s "${PREFIX}" |
    gzip -d |
    sed -n 's|.*</a></span></div><a href="\([A-Za-z0-9_\/]\+\)"><div class="book".*|\1|p'
}

BOOK="$(get_free_book_url)"

echo "${BOOK@Q}"
curl -#O -C - "${PREFIX}/download/${BOOK##*/}.pdf"
