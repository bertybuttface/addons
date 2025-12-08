<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

# Changelog

## 2.4.0

- Update upstream to latest.

## 2.3.0

- Update upstream to latest
- Remove patch for aiohttp, now included upstream
- Add minimum_skip_length config option to skip segments shorter than this value (in seconds)
- Add join_name config option to show the name of the device when connecting / disconnecting

## 2.2.0

- Add help text to config page (translation PRs highly encouraged)
- Add automatic translations to config page (de, en, es, fr, ro)
- Fix schema UI for skip_categories
- Fix schema for channel whitelisting
- Fix schema so api_key is not required
- Switch from pip to uv to speed up builds
- Update python 3.12 --> 3.13
- Update alpine 3.19 --> 3.21
- Update upstream to latest (and a patch for latest aiohttp)

## 2.1.2

- Fix --data-dir renamed to --data upstream issue with previous release

## 2.1.1

- Fix Autoplay always enabled issue due to incorrect key in config file. Thanks @suth and @the8thsign (see: https://github.com/bertybuttface/addons/pull/35 for details)

## 2.1.0

- Update upstream to latest with fix for overlapping slots

## 2.0.10

- Update python 3.10 --> 3.12
- Update alpine 3.16 --> 3.19
- Bump upstream to latest

## 2.0.9

- Fix major issue with prior release which wasn't tested (apologies)

## 2.0.8

- Bump upstream to latest

## 2.0.7

- Bump upstream to fix task exception was never retrieved issue.

## 2.0.6

- Bump upstream to add additional logging to debug issues.

## 2.0.5

- Merge upstream autoplay fix

## 2.0.4

- Merge upstream

## 2.0.3

- Fix symlink issue on addon restart

## 2.0.2

- Upstream removed the ability to specify config file, trying to use symlink to compensate.

## 2.0.1

WARNING: If you have issues with the 2.x.x series clear your config and start again.

- Hotfix release to fix config issues and some github issues

## 2.0.0

WARNING: This release is entirely incompatible with old releases, you may need to reinstall.

- Bump upstream release to 2.0.0

## 1.0.4

- Bump upstream pyatv release

## 1.0.3

- Add experimental support for local_addr

## 1.0.2

- Fix channel whitelist support

## 1.0.1

- Add channel whitelist support

## 1.0.0

- Initial release
