# Home Assistant Add-on: iSponsorBlockTV

You must run iSponsorBLockTV on the same network as the Apple TV. This addon requies host networking.

It connects to the Apple TV, watches foe activity and skis any sponsor segment using the SponsorBlock API.

The last 5 videos' segments are cached to limit the number on queries on SponsorBlock and YouTube.

## How to use

The easiest way to get started is to generate a config file by running this app on another machine.

```
docker run --rm -it --network=host -v /tmp/config.json:/app/config.json ghcr.io/dmunozv04/isponsorblocktv --setup && cat /tmp/config.json
```

You can then pick the bits out that you need.

You must also set a YouTube API key as apikey.
