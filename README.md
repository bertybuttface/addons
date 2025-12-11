<div align="center">

# Home Assistant Community Add-ons

**Community-maintained add-ons for Home Assistant**

[![License](https://img.shields.io/github/license/bertybuttface/addons?style=flat-square)](LICENSE)
[![GitHub Activity](https://img.shields.io/github/commit-activity/m/bertybuttface/addons?style=flat-square)](https://github.com/bertybuttface/addons/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/bertybuttface/addons?style=flat-square)](https://github.com/bertybuttface/addons/issues)

[![Add Repository](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbertybuttface%2Faddons)

</div>

---

## Available Add-ons

### 🎬 [iSponsorBlockTV](./isponsorblocktv)

[![Version](https://img.shields.io/badge/version-2.6.1-blue?style=flat-square)](./isponsorblocktv/CHANGELOG.md)
![aarch64](https://img.shields.io/badge/aarch64-yes-success?style=flat-square)
![amd64](https://img.shields.io/badge/amd64-yes-success?style=flat-square)

Automatically skip sponsor segments in YouTube videos on YouTube TV devices using the SponsorBlock API. Community wrapper around [dmunozv04/iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV).

**Features:**
- Automatic sponsor segment skipping via SponsorBlock
- YouTube ad skipping and muting
- Multi-device support
- Channel whitelisting
- Configurable skip categories

[📖 Documentation](./isponsorblocktv/DOCS.md) • [📝 Changelog](./isponsorblocktv/CHANGELOG.md)

---

### 🔒 [OpenZiti Tunneller](./zititunneller)

[![Version](https://img.shields.io/badge/version-1.2.0-blue?style=flat-square)](./zititunneller/CHANGELOG.md)
![aarch64](https://img.shields.io/badge/aarch64-yes-success?style=flat-square)
![amd64](https://img.shields.io/badge/amd64-yes-success?style=flat-square)

Connect Home Assistant to an OpenZiti zero trust overlay network. Community wrapper around [openziti/ziti-tunnel-sdk-c](https://github.com/openziti/ziti-tunnel-sdk-c).

**Features:**
- Zero trust networking without port forwarding
- Secure encrypted connections
- No VPN required
- Private overlay network access
- Remote access without exposing to internet

[📖 Documentation](./zititunneller/DOCS.md) • [📝 Changelog](./zititunneller/CHANGELOG.md)

---

## Installation

Click the badge above or add this repository URL in Home Assistant:

```
https://github.com/bertybuttface/addons
```

Then install add-ons from **Settings** → **Add-ons** → **Add-on Store**.

---

## Support

- 📖 [Home Assistant Add-on Documentation](https://developers.home-assistant.io/docs/add-ons)
- 🐛 [Report Issues](https://github.com/bertybuttface/addons/issues)
- 💬 [Community Forum](https://community.home-assistant.io/)

---

## Deprecated Add-ons

<details>
<summary>⚠️ No longer maintained</summary>

### Whos At My Feeder

Bird species identification sidecar for Frigate. **No longer maintained.**

</details>

<!--

Notes to developers after forking or using the github template feature:
- While developing comment out the 'image' key from 'example/config.yaml' to make the supervisor build the addon
  - Remember to put this back when pushing up your changes.
- When you merge to the 'main' branch of your repository a new build will be triggered.
  - Make sure you adjust the 'version' key in 'example/config.yaml' when you do that.
  - Make sure you update 'example/CHANGELOG.md' when you do that.
  - The first time this runs you might need to adjust the image configuration on github container registry to make it public
  - You may also need to adjust the github Actions configuration (Settings > Actions > General > Workflow > Read & Write)
- Adjust the 'image' key in 'example/config.yaml' so it points to your username instead of 'home-assistant'.
  - This is where the build images will be published to.
- Rename the example directory.
  - The 'slug' key in 'example/config.yaml' should match the directory name.
- Adjust all keys/url's that points to 'home-assistant' to now point to your user/fork.
- Share your repository on the forums https://community.home-assistant.io/c/projects/9
- Do awesome stuff!
 -->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
