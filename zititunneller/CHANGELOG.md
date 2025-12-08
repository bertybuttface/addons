<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 1.1.0

**Breaking Changes:**
- Configuration key `jwt` renamed to `ziti_enroll_token` for clarity
  - **Action required:** Update your addon configuration to use `ziti_enroll_token` instead of `jwt`

**Major Updates:**
- Update OpenZiti ziti-edge-tunnel from v0.22.20 to v1.9.7 (major version upgrade)
- Migrate to modern s6-overlay v3 s6-rc directory structure
- Use oneshot service for initialization and longrun for main tunnel daemon
- Improved service dependency management with proper ordering

## 1.0.5

- Pin specific Ziti version so we can track releases.
- Update to v0.22.20

## 1.0.4

- Untracked changes

## 1.0.3

- Fix for script exiting prematurely

## 1.0.3

- Make JWT optional to improve account reuse.
- Add some additional logging

## 1.0.2

- Switch to Debian base image.

## 1.0.1

- Fix curl issue

## 1.0.0

- Initial release
