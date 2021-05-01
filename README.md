[linuxserverurl]: https://linuxserver.io
[appurl]: https://www.qbittorrent.org
[hub]: https://hub.docker.com/r/omegagoth/nordvpn-qbittorrent/
[openpynurl]: https://github.com/jotyGill/openpyn-nordvpn/

Based on the [LinuxServer.io][linuxserverurl] image for qbittorrent and [openpyn-nordvpn][openpynurl].
This create a docker with a qBittorrent instance running with the web-ui and all the traffic double encrypted: passing through an OpenVPN server of NordVPN and using the Socks5 protocol of the same server.

I have modified the original image by omegagoth to include ping, as the openpyn script needs ping to test latency to different servers. I have also switched over the install commands to Aptitude from APK as the linuxserver/qbittorrent image was rebased to Ubuntu Focal recently. 

# omegagoth/nordvpn-qbittorrent
[![](https://images.microbadger.com/badges/version/omegagoth/nordvpn-qbittorrent.svg)](https://microbadger.com/images/omegagoth/nordvpn-qbittorrent "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/omegagoth/nordvpn-qbittorrent.svg)](https://microbadger.com/images/omegagoth/nordvpn-qbittorrent "Get your own image badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/omegagoth/nordvpn-qbittorrent.svg)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/omegagoth/nordvpn-qbittorrent.svg)][hub]

The [qBittorrent][appurl] project aims to provide an open-source software alternative to µTorrent.
qBittorrent is based on the Qt toolkit and libtorrent-rasterbar library.

[![qbittorrent](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/qbittorrent-icon.png)][appurl]

The [openpyn-nordvpn][openpynurl] aims to provide an easy connection and switch between, OpenVPN servers hosted by NordVPN on Linux.

## Usage

```
docker create \
  --name=nordvpn-qbittorrent \
  -v <path to config>:/config \
  -v <path to downloads>:/downloads \
  -v /etc/localtime:/etc/localtime:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e UMASK_SET=<022> \
  -e WEBUI_PORT=<8080> \
  -e NORDVPN_USERNAME=<username>
  -e NORDVPN_PASSWORD=<password>
  -e OPENPYN_SERVERNUMBER=<5>
  -e OPENPYN_COUNTRY=<nl>
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 8080:8080 \
  omegagoth/nordvpn-qbittorrent
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 6881` - the port(s)
* `-p 6881/udp` - the port(s)
* `-p 8080` - webui port 
* `-v /config` - where qbittorrent should store its config files
* `-v /downloads` - path to downloads
* `-v /etc/localtime` - path to the localtime directory of your local OS
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e UMASK_SET` for umask setting of qbittorrent, *optional* , default if left unset is 022. 
* `-e WEBUI_PORT` for changing the port of the webui, see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it nordvpn-qbittorrent /bin/bash`.

## WEBUI_PORT variable

Due to issues with CSRF and port mapping, should you require to alter the port for the webui you need to change both sides of the `-p 8080` switch **AND** set the `WEBUI_PORT` variable to the new port.

For example,  to set the port to 8090 you need to set `-p 8090:8090` and `-e WEBUI_PORT=8090`

This should alleviate the "white screen" issue.

If you have no webui , check the file /config/qBittorrent/qBittorrent.conf

edit or add the following lines

```
WebUI\Address=*

WebUI\ServerDomains=*
```

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

The webui is at `<your-ip>:8080` and the default username/password is `admin/adminadmin`.

Change username/password via the webui in the webui section of settings.


## Info

Shell access whilst the container is running: `docker exec -it nordvpn-qbittorrent /bin/bash`

To monitor the logs of the container in realtime: `docker logs -f nordvpn-qbittorrent`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' nordvpn-qbittorrent`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' omegagoth/nordvpn-qbittorrent`

## Versions

+ **13.10.18:** Initial Release.
