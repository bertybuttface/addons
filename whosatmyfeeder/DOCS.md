# Home Assistant Add-on: WhosAtMyFeeder

This addon is unsupported but it should work.

As a prerequisite of running this project, you must set up Frigate to detect the 'bird' object in a video stream, and to send out snapshots. This also assumes you have setup a MQTT broker, like Mosquitto MQTT

## Setup

1. Configure your MQTT server (leave default if you haven't changed it)
2. Setup a username and password on your MQTT server for whosatmyfeeder
3. Configure the cameras you want to monitor and run the addon.

## How to use

This addon uses ingress to open a web UI in a Home Assistant tab. No further config is required.
