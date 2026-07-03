#!/usr/bin/env bash
#
# Exports every commit between the local main bookmark and HEAD of the
# repo in the current directory as patch files, and drops them into
# the matching vcpkg port so the port can apply them on top of its
# pinned REF.
#
# Run from the repo you want to export, e.g.:
#   cd ../core && ../carbonengine-linux/export-port-patches.sh
set -euo pipefail

VCPKG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(pwd)"
PORT_NAME="carbon-$(basename "${REPO_ROOT}")"
PORT_DIR="${VCPKG_ROOT}/ports/${PORT_NAME}"
PORTFILE="${PORT_DIR}/portfile.cmake"
PATCHES_BEGIN="# BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)"
PATCHES_END="# END EXPORTED PATCHES"

if [ ! -d "${REPO_ROOT}/.git" ]; then
  echo "error: not a git repository: ${REPO_ROOT}" >&2
  exit 1
fi

if [ ! -d "${PORT_DIR}" ]; then
  echo "error: port directory not found: ${PORT_DIR}" >&2
  exit 1
fi

if [ ! -f "${PORTFILE}" ] || ! grep -qF "${PATCHES_BEGIN}" "${PORTFILE}"; then
  echo "error: ${PORTFILE} has no '${PATCHES_BEGIN}' marker" >&2
  exit 1
fi

# Remove previously exported patches so removed/rebased commits don't
# leave stale files behind.
find "${PORT_DIR}" -maxdepth 1 -name '*.patch' -delete

git -C "${REPO_ROOT}" format-patch main..HEAD \
  --no-signature \
  --zero-commit \
  -o "${PORT_DIR}"

PATCHES=$(find "${PORT_DIR}" -maxdepth 1 -name '*.patch' -printf '%f\n' | sort)

# Rewrite the marked block in portfile.cmake with the current patch list.
awk -v begin="${PATCHES_BEGIN}" -v end="${PATCHES_END}" -v patches="${PATCHES}" '
  $0 ~ begin { print; if (patches != "") print patches; skip=1; next }
  $0 ~ end   { skip=0 }
  !skip { print }
' "${PORTFILE}" > "${PORTFILE}.tmp"
mv "${PORTFILE}.tmp" "${PORTFILE}"

echo "Exported patches to ${PORT_DIR}:"
echo "${PATCHES}" | sed 's/^/  /'
echo "Updated ${PORTFILE}"
