#!/bin/bash
set -e

# This script is run by Renovate to automatically update the isponsorblocktv addon
# when a new version of dmunozv04/iSponsorBlockTV is released.
#
# It updates:
# 1. The version in isponsorblocktv/config.yaml
# 2. The CHANGELOG.md with the new version and upstream release notes

ADDON_DIR="isponsorblocktv"
CONFIG_FILE="${ADDON_DIR}/config.yaml"
CHANGELOG_FILE="${ADDON_DIR}/CHANGELOG.md"

# Get the new version from the Dockerfile ARG
NEW_VERSION=$(grep "ARG ISPONSORBLOCKTV_VERSION=" "${ADDON_DIR}/Dockerfile" | cut -d'=' -f2)
# Remove the 'v' prefix for the addon version
ADDON_VERSION="${NEW_VERSION#v}"

echo "Updating isponsorblocktv addon to version ${ADDON_VERSION}"

# Update config.yaml version
sed -i.bak "s/^version: \".*\"/version: \"${ADDON_VERSION}\"/" "${CONFIG_FILE}"
rm -f "${CONFIG_FILE}.bak"

echo "Updated ${CONFIG_FILE} to version ${ADDON_VERSION}"

# Fetch release notes from GitHub API
RELEASE_NOTES=$(curl -s "https://api.github.com/repos/dmunozv04/iSponsorBlockTV/releases/tags/${NEW_VERSION}" | \
  jq -r '.body // "No release notes available"' | \
  sed 's/^/- /' | \
  head -20)

# Create new CHANGELOG entry
CHANGELOG_ENTRY="## ${ADDON_VERSION}

**Addon Changes:**
- Update iSponsorBlockTV to ${NEW_VERSION}

**Upstream iSponsorBlockTV ${NEW_VERSION}:**
${RELEASE_NOTES}

"

# Insert new entry after the first line (the header comment) and before the existing content
# Use a temporary file to avoid sed platform differences
{
  head -n 3 "${CHANGELOG_FILE}"  # Keep the header
  echo "${CHANGELOG_ENTRY}"
  tail -n +4 "${CHANGELOG_FILE}"  # Rest of the file
} > "${CHANGELOG_FILE}.tmp"

mv "${CHANGELOG_FILE}.tmp" "${CHANGELOG_FILE}"

echo "Updated ${CHANGELOG_FILE} with new version ${ADDON_VERSION}"
echo "Changes:"
echo "- config.yaml: ${ADDON_VERSION}"
echo "- CHANGELOG.md: Added entry for ${ADDON_VERSION}"
