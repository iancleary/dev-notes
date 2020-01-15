# UniFi Wireless Access Point on a Raspberry Pi

I followed the recommendation of Jupiter Broadcasting's [Self Hosted Extras: Fixing Brent's WiFi](https://www.jupiterbroadcasting.com/138397/self-hosted-fixing-brents-wifi-jupiter-extras-45/) and purchased a [Ubiquiti Networks Unifi 802.11ac Dual-Radio PRO Access Point (UAP-AC-PRO-US), Single](https://www.amazon.com/Ubiquiti-Networks-802-11ac-Dual-Radio-UAP-AC-PRO-US/dp/B015PRO512) from Amazon.

----

It is very nice to have the WiFi Access Point (WAP) separated from my modem!

The WiFi router was becoming very sluggish, but the modem functionality has remained much more stable and close to the performance when I first purchased it.

## Controller Client

You need to a controller (the WAP doesn't have it's own login portal, like most Modem/WAP combo units do)

> I decided to set up the UniFi controller software on my Raspberry Pi 3B+. It has proven to be a great appliance to host several small utilities.

First thought was Docker. There had to be a Docker image for this!

A community project for UniFi Docker images can be found here: [GitHub jacobalberty/unifi-docker](https://github.com/jacobalberty/unifi-docker).

The Raspberry Pi is an ARM board and requires a special tag. See <https://hub.docker.com/r/jacobalberty/unifi/tags> for the full list of tags.

## ARM32 Docker Image

```bash
docker pull jacobalberty/unifi:arm32v7
```

## Full Setup Script

```bash
mkdir -p ~/unifi/data
mkdir -p ~/unifi/log
docker run --rm --init -d -p 8080:8080 -p 8443:8443 -p 3478:3478/udp -p 10001:10001/udp -e TZ='America/Phoenix' -v ~/unifi:/unifi --name unifi jacobalberty/unifi:arm32v7
```

## Start on Boot with SystemD

I followed Luis Toubes' article, ["How to start a Docker container at boot time"](https://toub.es/2017/08/08/how-to-start-a-docker-container-at-boot-time/), and created a systemd file:

### Create unifi.service

```systemd.service
[Unit]
Description=My UniFi Controller
Requires=docker.service
After=docker.service

[Service]
#Restart=always
ExecStart=/usr/bin/docker run --rm --init -d -p 8080:8080 -p 8443:8443 -p 3478:3478/udp -p 10001:10001/udp -e TZ='America/Phoenix' -v ~/unifi:/unifi --name unifi jacobalberty/unifi:arm32v7
ExecStop=/usr/bin/docker stop -t 2 unifi

[Install]
WantedBy=default.target
```

## Make systemd see your service

### Copy file from step 1 to `/etc/systemd/system`

```bash
sudo cp unifi.service /etc/systemd/system/
```

### Give execution rights to the file

```bash
chmod +x unifi.service
```

## SystemD Options

### Enable the service on boot

```bash
sudo systemctl enable rpi-agario
```

### Check current status

```bash
sudo systemctl status rpi-agario
```

### Disable the service from boot

```bash
sudo systemctl disable rpi-agario
```
