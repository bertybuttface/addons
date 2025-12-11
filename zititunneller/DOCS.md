# Home Assistant Add-on: zititunneller

**Community-maintained Home Assistant addon wrapper around [OpenZiti ziti-tunnel-sdk-c](https://github.com/openziti/ziti-tunnel-sdk-c)**

This addon connects your Home Assistant instance to an [OpenZiti](https://openziti.io/) zero trust overlay network. OpenZiti provides secure, encrypted networking without requiring port forwarding, VPNs, or exposing your Home Assistant instance directly to the internet.

## What is OpenZiti?

OpenZiti is an open-source zero trust networking platform that creates secure, encrypted overlay networks. It allows you to:

- Access your Home Assistant remotely without opening firewall ports
- Connect services across different networks securely
- Apply zero trust principles (never trust, always verify)
- Eliminate the need for traditional VPNs

This addon runs the OpenZiti edge tunnel client, which you configure through your OpenZiti controller.

## Installation

Add this repository to your Home Assistant add-on store, then install the "ziti-tunneller" addon from the store.

## Configuration

To connect to your OpenZiti network, you need an enrollment token (JWT) from your OpenZiti controller. This token is generated when you create a new identity in your OpenZiti network.

1. Create an identity in your OpenZiti controller
2. Download the JWT enrollment token
3. Paste the JWT content into the addon configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
log_level: info
jwt: ...
```

### Option: `log_level`

The `log_level` option controls the level of log output by the add-on and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `jwt`

The content of the jwt file you can download from the ZAC (OpenZiti Administration Console) or your controller returns after creating a new identity.

## Authors & contributors

The original setup of this repository is by Mattanja D. Heck <mattanjaheck@t-online.de>.

Modifications were made by bertybuttface.

## License

MIT License

Copyright (c) 2022 Mattanja D. Heck

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
