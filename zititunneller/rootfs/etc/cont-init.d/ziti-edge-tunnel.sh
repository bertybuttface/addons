#!/command/with-contenv bashio
# Configure ziti-edge-tunnel before running

# Fetch ZITI_ENROLL_TOKEN from config
ZITI_ENROLL_TOKEN="$(bashio::config 'ziti_enroll_token')"

# Check if ziti-edge-tunnel exists and is executable
if [ ! -x /opt/ziti-edge-tunnel ]; then
  echo "Error: /opt/ziti-edge-tunnel not found or not executable"
  exit 1
fi

# Check if ZITI_ENROLL_TOKEN env is set and not empty
if [ -n "${ZITI_ENROLL_TOKEN}" ] && [ "${ZITI_ENROLL_TOKEN}" != "null" ]; then
  echo "ZITI_ENROLL_TOKEN is set, enrolling new identity"
  # Enroll identity
  echo "${ZITI_ENROLL_TOKEN}" > /identities/default.ZITI_ENROLL_TOKEN
  /opt/ziti-edge-tunnel enroll --ZITI_ENROLL_TOKEN /identities/default.ZITI_ENROLL_TOKEN --identity /identities/default.json
else
  echo "ZITI_ENROLL_TOKEN not set, using stored identity if there is one"
  # Check if /identities/default.json exists, if it doesn't error out
  if [ -f "/identities/default.json" ]; then
    echo "Stored identity found at /identities/default.json"
  else
    echo "Error: No stored identity found at /identities/default.json" >&2
    ls /identities
    exit 1
  fi
fi
