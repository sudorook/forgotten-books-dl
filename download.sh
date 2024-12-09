#!/bin/bash

# SPDX-FileCopyrightText: 2024 sudorook <daemon@nullcodon.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.

set -euo pipefail

PREFIX="https://www.forgottenbooks.com/en"

function get_free_book_url {
  curl -s "${PREFIX}" |
    gzip -d |
    sed -n 's|.*</a></span></div><a href="\([A-Za-z0-9_\/]\+\)"><div class="book".*|\1|p'
}

BOOK="$(get_free_book_url)"
BOOK=${BOOK##*/}

echo -n "Downloading ${BOOK@Q}... "
curl -sO -C - "${PREFIX}/download/${BOOK}.pdf"
echo "done."
