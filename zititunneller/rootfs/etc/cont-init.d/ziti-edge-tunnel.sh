#!/command/with-contenv bashio
# Configure ziti-edge-tunnel before running

# Fetch jwt from config
JWT="$(bashio::config 'jwt')"

# Check if ziti-edge-tunnel exists and is executable
if [ ! -x /opt/ziti-edge-tunnel ]; then
  echo "Error: /opt/ziti-edge-tunnel not found or not executable"
  exit 1
fi

# Check if JWT env is set and not empty
if [ -n "${JWT}" ] && [ "${JWT}" != "null" ]; then
  echo "JWT is set, enrolling new identity"
  # Enroll identity
  echo "${JWT}" > /identities/default.jwt
  /opt/ziti-edge-tunnel enroll --jwt /identities/default.jwt --identity /identities/default.json
else
  echo "JWT not set, using stored identity if there is one"
  # Check if /identities/default.json exists, if it doesn't error out
  if [ -f "/identities/default.json" ]; then
    echo "Stored identity found at /identities/default.json"
  else
    echo "Error: No stored identity found at /identities/default.json" >&2
    ls /identities
    exit 1
  fi
fi
