# darkhttpd

darkhttpd is a simple, static web server. No configuration file, no CGI.

**Features**:

* Simple to set up:
  * Single binary, no other files, no installation needed.
  * Standalone, doesn't need `inetd` or `ucspi-tcp`.
  * No messing around with config files - all you have to specify is the `www` root.
* Written in C - efficient and portable.
* Small memory footprint.
* Event loop, single threaded - no fork() or pthreads.
* Generates directory listings.
* Supports HTTP GET and HEAD requests.
* Supports Range / partial content. (try streaming music files or resuming a download)
* Supports If-Modified-Since.
* Supports Keep-Alive connections.
* Supports IPv6.
* Support arbitrary custom response headers.
* Can serve 301 redirects based on Host header.
* Uses sendfile() on FreeBSD, Solaris and Linux.
* Can use acceptfilter on FreeBSD.
* Can use chroot as non-root on FreeBSD 14+.
* At some point worked on FreeBSD, Linux, OpenBSD, Solaris.
* ISC license.
* suckless.org says [darkhttpd sucks less](http://suckless.org/rocks/).
* Small Docker image (<100KB)

**Security**:

* Can log accesses, including Referer and User-Agent.
* Can chroot.
* Can drop privileges.
* Impervious to `/../` sniffing.
* Times out idle connections.
* Drops overly long requests.

**Limitations**:

* Only serves static content - no CGI.

unix4lyfe.org/darkhttpd

## How to use this Makejail

### Basic usage

```console
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    ghcr.io/appjail-makejails/darkhttpd darkhttpd
```

### Using a host's directory

```console
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -o fstab="/usr/local/poudriere/data/packages /usr/local/www nullfs ro" \
    ghcr.io/appjail-makejails/darkhttpd darkhttpd
```

### Arguments (stage: build)

* `darkhttpd_from` (default: `ghcr.io/appjail-makejails/darkhttpd`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `darkhttpd_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
