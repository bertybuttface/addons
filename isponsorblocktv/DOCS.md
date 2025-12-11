# Home Assistant Add-on: iSponsorBlockTV

**Community-maintained Home Assistant addon wrapper around [dmunozv04/iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV)**

This addon automatically skips sponsor segments in YouTube videos playing on YouTube TV devices. It connects to your YouTube TV (Smart TV, Chromecast, etc.), monitors video playback, and uses the [SponsorBlock](https://sponsor.block/) crowdsourced database to skip sponsored segments. It can also skip or mute YouTube ads.

## Features

- Automatically skip sponsor segments using SponsorBlock API
- Skip or mute YouTube video ads
- Support for multiple YouTube TV devices
- Channel whitelisting
- Configurable skip categories (sponsor, selfpromo, intro, outro, etc.)
- Host networking for automatic device discovery

This addon runs iSponsorBlockTV and requires network access to communicate with your YouTube TV devices. Auto-discovery requires the addon to be on the same network as your devices during initial setup.

## How to use

The easiest way to get started is to generate a config file by running this app on another machine.

You will need to get a connection key by opening the Youtube app on your device, going to settings and selecting tv link.

```
rm -rf /tmp/config && mkdir /tmp/config && docker run --rm -it -v /tmp/config:/app/data --net=host ghcr.io/dmunozv04/isponsorblocktv --setup-cli && cat /tmp/config/config.json
```

You can then pick the bits out that you need.

The config file will look something like this:

```json
{
    "devices": [
        {
            "screen_id": "[YOUR SCREEN-ID]",
            "name": "YouTube on TV",
            "offset": 0
        }
    ],
    "apikey": "",
    "skip_categories": [
        "sponsor"
    ],
    "channel_whitelist": [],
    "skip_count_tracking": true,
    "mute_ads": false,
    "skip_ads": true
}
```

You can then transfer the device config over to a YAML config which looks like this:

```yml
- screen_id: [YOUR SCREEN-ID]
  name: LG TV
```



You must also set a YouTube API key as apikey.

## Troubleshooting

### No devices discovered
- Ensure the addon is using host networking (already configured by default)
- Verify your YouTube TV device is on the same network as your Home Assistant instance
- Check if the device is powered on and connected to your network
- Try restarting the addon after ensuring the device is online

### YouTube API key issues
- Verify your API key is correctly entered in the configuration
- Ensure you have enabled the YouTube Data API v3 in your Google Cloud Console
- Check that your API key has the correct permissions
- Visit [Google's YouTube API documentation](https://developers.google.com/youtube/registering_an_application) for setup instructions

### Segments not being skipped
- Verify the video has sponsor segments in the SponsorBlock database
- Check that your `skip_categories` configuration includes the type of segment you want to skip
- Review addon logs for any errors or connection issues
- Ensure `skip_ads` is set to `true` if you want ads skipped

For more help, check the [upstream project's documentation](https://github.com/dmunozv04/iSponsorBlockTV) or open an issue on the [addon repository](https://github.com/bertybuttface/addons/issues).
