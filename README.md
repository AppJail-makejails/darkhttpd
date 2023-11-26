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

```sh
appjail makejail -j darkhttpd -f gh+AppJail-makejails/darkhttpd \
    -o virtualnet=":<random> default" \
    -o nat
```

### Using a host's directory

```sh
appjail makejail -j darkhttpd -f gh+AppJail-makejails/darkhttpd \
    -o virtualnet=":<random> default" \
    -o nat \
    -o fstab="/usr/local/poudriere/data/packages/132amd64-default /usr/local/www/darkhttpd" \
    -o expose=3080:80
```

**Note**: The above example exposes port `3080`. It is not necessary unless you plan to expose this service. Read more information on [Port Forwarding](https://appjail.readthedocs.io/en/latest/networking/virtual-networks/port-forwarding/).

### Arguments

* `darkhttpd_tag` (default: `13.2`): see [#tags](#tags).

## Tags

| Tag    | Arch    | Version        | Type   |
| ------ | ------- | -------------- | ------ |
| `13.2` | `amd64` | `13.2-RELEASE` | `thin` |
| `14.0` | `amd64` | `14.0-RELEASE` | `thin` |
