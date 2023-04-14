# Home Assistant Add-on: zititunneller

This addon lets you connect your homeassistant to an existing [ZITI](https://openziti.github.io/) network.
It contains an ziti-tunneller which you can configure through your ZITI controller.

## Installation

Copy the `zititunneller` folder into the `/addons/` folder of your Home Assistant OS installation.

*Note: For the addon to appear initially, the supervisor has to be restarted (use the ha-cli).*

*For updates to appear, use the "Check for updates" button in the Addon-Store*

### SCP commands (for reference)
```bash
scp -r zititunneller homeassistant:/addons/ && scp CHANGELOG.md homeassistant:/addons/zititunneller/
```

## Configuration

You only need to add the JWT your ZITI controller generates when you add a new identity.

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

The content of the jwt file you can download from the ZAC or your controller returns after creating a new identity.

## Development
**IMPORTANT:** *You need to adjust the version number in `zititunneller/config.yaml` manually!*

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
