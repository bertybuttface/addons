#!/bin/bash
set -e

# This script is run by Renovate to automatically update the zititunneller addon
# when a new version of openziti/ziti-tunnel-sdk-c is released.
#
# It updates:
# 1. The version in zititunneller/config.yaml (minor version bump)
# 2. The CHANGELOG.md with the new version and upstream release notes

ADDON_DIR="zititunneller"
CONFIG_FILE="${ADDON_DIR}/config.yaml"
CHANGELOG_FILE="${ADDON_DIR}/CHANGELOG.md"

# Get the new version from the Dockerfile ARG
NEW_VERSION=$(grep "ARG ZITI_VERSION=" "${ADDON_DIR}/Dockerfile" | cut -d'=' -f2)

echo "Updating zititunneller addon for OpenZiti ${NEW_VERSION}"

# Get current addon version and increment minor version
CURRENT_VERSION=$(grep "^version:" "${CONFIG_FILE}" | awk '{print $2}')
MAJOR=$(echo "${CURRENT_VERSION}" | cut -d'.' -f1)
MINOR=$(echo "${CURRENT_VERSION}" | cut -d'.' -f2)
NEW_MINOR=$((MINOR + 1))
ADDON_VERSION="${MAJOR}.${NEW_MINOR}.0"

echo "Bumping addon version from ${CURRENT_VERSION} to ${ADDON_VERSION}"

# Update config.yaml version
sed -i.bak "s/^version: .*/version: ${ADDON_VERSION}/" "${CONFIG_FILE}"
rm -f "${CONFIG_FILE}.bak"

echo "Updated ${CONFIG_FILE} to version ${ADDON_VERSION}"

# Fetch release notes from GitHub API
RELEASE_NOTES=$(curl -s "https://api.github.com/repos/openziti/ziti-tunnel-sdk-c/releases/tags/${NEW_VERSION}" | \
  jq -r '.body // "No release notes available"' | \
  sed 's/^/- /' | \
  head -20)

# Create new CHANGELOG entry
CHANGELOG_ENTRY="## ${ADDON_VERSION}

- Update OpenZiti ziti-edge-tunnel to ${NEW_VERSION}

**Upstream OpenZiti ${NEW_VERSION}:**
${RELEASE_NOTES}

"

# Insert new entry after the first line (the header comment) and before the existing content
{
  head -n 2 "${CHANGELOG_FILE}"  # Keep the header
  echo "${CHANGELOG_ENTRY}"
  tail -n +3 "${CHANGELOG_FILE}"  # Rest of the file
} > "${CHANGELOG_FILE}.tmp"

mv "${CHANGELOG_FILE}.tmp" "${CHANGELOG_FILE}"

echo "Updated ${CHANGELOG_FILE} with new version ${ADDON_VERSION}"
echo "Changes:"
echo "- config.yaml: ${ADDON_VERSION}"
echo "- CHANGELOG.md: Added entry for ${ADDON_VERSION}"
