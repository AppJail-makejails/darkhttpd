# darkhttpd

darkhttpd is a simple, static web server. No configuration file, no CGI.

## Features:

* Simple to set up:
  - Single binary, no other files, no installation needed.
  - Standalone, doesn't need inetd or ucspi-tcp.
  - No messing around with config files - all you have to specify is the www root.
* Written in C - efficient and portable.
* Small memory footprint.
* Event loop, single threaded - no fork() or pthreads.
* Generates directory listings.
* Supports HTTP GET and HEAD requests.
* Supports Range / partial content. (try streaming music files or resuming a download)
* Supports If-Modified-Since.
* Supports Keep-Alive connections.
* Supports IPv6.
* Can serve 301 redirects based on Host header.
* Uses sendfile() on FreeBSD, Solaris and Linux.
* Can use acceptfilter on FreeBSD.
* At some point worked on FreeBSD, Linux, OpenBSD, Solaris.
* ISC license.
* suckless.org says darkhttpd sucks less.

## Security:

* Can log accesses, including Referer and User-Agent.
* Can chroot.
* Can drop privileges.
* Impervious to /../ sniffing.
* Times out idle connections.
* Drops overly long requests.

## Limitations:

* Only serves static content - no CGI.

unix4lyfe.org/darkhttpd

## How to use this Makejail

### Basic usage

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/darkhttpd
```

Where `options/network.makejail` are the options that suit your environment, for example:

```
ARG network
ARG interface=darkhttpd

OPTION virtualnet=${network}:${interface} default
OPTION nat
```

Open a shell and run `appjail makejail`:

```sh
appjail makejail -j darkhttpd -- --network testing
```

### Using a host's directory

```
INCLUDE options/network.makejail

SYSRC "darkhttpd_flags=--uid darkhttpd --gid darkhttpd --log /var/log/darkhttpd.log"

INCLUDE gh+AppJail-makejails/darkhttpd

OPTION expose=80

ARG wwwdir=/usr/local/www/darkhttpd

CMD --local mkdir -p "${wwwdir}"
MOUNT "${wwwdir}" /usr/local/www/darkhttpd
```

Darkhttpd does not have a configuration file like other web servers, it simply uses command-line options, so we can pass options through `darkhttpd_flags`. Note that `darkhttpd_flags` is enclosed in quotes as `sysrc(8)` will complain about the hyphens.

The port (external and internal) `80` is used as you can see, but use any port you want.
