#!/command/with-contenv bashio
# Configure ziti-edge-tunnel before running

# Fetch jwt from config
JWT="$(bashio::config 'jwt')"

# Translate log level
case "$(bashio::config 'log_level')" in
  error)
    LOG_LEVEL="1"
    ;;
  warning)
    LOG_LEVEL="2"
    ;;
  info)
    LOG_LEVEL="3"
    ;;
  debug)
    LOG_LEVEL="4"
    ;;
  *)
    LOG_LEVEL="3"
    ;;
esac

# Check if ziti-edge-tunnel exists and is executable
if [ ! -x /opt/ziti-edge-tunnel ]; then
  echo "Error: /opt/ziti-edge-tunnel not found or not executable"
  exit 1
fi

# Enroll identity
echo "${JWT}" > /identities/default.jwt
/opt/ziti-edge-tunnel enroll --jwt /identities/default.jwt --identity /identities/default.json
