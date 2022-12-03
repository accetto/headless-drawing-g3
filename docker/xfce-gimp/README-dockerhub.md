# Headless Ubuntu/Xfce container with VNC/noVNC and `gimp`

## accetto/ubuntu-vnc-xfce-gimp-g3

[Docker Hub][this-docker] - [Git Hub][this-github] - [Dockerfile][this-dockerfile] - [Full Readme][this-readme-full] - [Changelog][this-changelog] - [Project Readme][this-readme-project] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]

![badge_latest_created][badge_latest_created]
[![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

***

- [Headless Ubuntu/Xfce container with VNC/noVNC and `gimp`](#headless-ubuntuxfce-container-with-vncnovnc-and-gimp)
  - [accetto/ubuntu-vnc-xfce-gimp-g3](#accettoubuntu-vnc-xfce-gimp-g3)
    - [Introduction](#introduction)
    - [TL;DR](#tldr)
      - [Installing packages](#installing-packages)
      - [Shared memory size](#shared-memory-size)
      - [Extending images](#extending-images)
      - [Building images](#building-images)
      - [Sharing devices](#sharing-devices)
    - [Description](#description)
    - [Image tags](#image-tags)
    - [Ports](#ports)
    - [Volumes](#volumes)
  - [Using headless containers](#using-headless-containers)
    - [Overriding VNC/noVNC parameters](#overriding-vncnovnc-parameters)
    - [Startup options and help](#startup-options-and-help)
    - [More information](#more-information)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)

***

### Introduction

This repository contains Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment, [VNC][tigervnc]/[noVNC][novnc] servers for headless use
and the free open-source bitmap image editor [gimp][gimp] from the `Ubuntu 20.04 LTS` distribution.

All images can optionally contain also the current [Chromium][chromium] or [Firefox][firefox] web browsers.

This is the **short README** version for the **Docker Hub**. There is also the [full-length README][this-readme-full] on the **GitHub**.

### TL;DR

#### Installing packages

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Ubuntu Packages Search][ubuntu-packages-search] page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```

#### Shared memory size

Note that some applications require larger shared memory than the default 64MB. Using 256MB usually solves crashes or strange behavior.

You can check the current shared memory size by executing the following command inside the container:

```shell
df -h /dev/shm
```

The Wiki page [Firefox multi-process][that-wiki-firefox-multiprocess] describes several ways, how to increase the shared memory size.

#### Extending images

The provided example file `Dockerfile.extend` shows how to use the images as the base for your own images.

Your concrete `Dockerfile` may need more statements, but the concept should be clear.

The compose file `example.yml` shows how to switch to another non-root user and how to set the VNC password and resolution.

#### Building images

The fastest way to build the images:

```shell
### PWD = project root
### prepare and source the 'secrets.rc' file first (see 'example-secrets.rc')

### examples of building and publishing the individual images
### 'gimp' stands for 'opengl' in this context
./builder.sh gimp all
./builder.sh gimp-chromium all
./builder.sh gimp-firefox all

### or skipping the publishing to the Docker Hub
./builder.sh gimp all-no-push

### examples of building and publishing the images as a group
./ci-builder.sh all group gimp gimp-firefox

### or all the images featuring the Gimp
./ci-builder.sh all group complete-gimp
```

You can still execute the individual hook scripts as before (see the folder `/docker/hooks/`). However, the provided utilities `builder.sh` and `ci-builder.sh` are more convenient. Before pushing the images to the **Docker Hub** you have to prepare and source the file `secrets.rc` (see `example-secrets.rc`). The script `builder.sh` builds the individual images. The script `ci-builder.sh` can build various groups of images or all of them at once. Check the files `local-builder-readme.md`, `local-building-example.md` and the sibling [Wiki][sibling-wiki] for more information.

#### Sharing devices

Sharing the audio device for video with sound works only with `Chromium` and only on Linux:

```shell
docker run -it -P --rm \
  --device /dev/snd:/dev/snd:rw \
  --group-add audio \
accetto/ubuntu-vnc-xfce-gimp-g3:chromium
```

Sharing the display with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-gimp-g3:latest --skip-vnc

xhost -local:$(whoami)
```

Sharing the X11 socket with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-gimp-g3:latest

xhost -local:$(whoami)
```

### Description

This is the **third generation** (G3) of my headless images. They replace the **second generation** (G2) of similar images from the GitHub repository [accetto/xubuntu-vnc][accetto-github-xubuntu-vnc], which will be archived.

More information about the image generations can be found in the [sibling project README][sibling-readme-project] file and the [sibling Wiki][sibling-wiki].

The main features and components of the images in the default configuration are:

- utilities **ping**, **wget**, **sudo** (Ubuntu distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (Ubuntu distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Ubuntu distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Ubuntu distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding both the container user account and its group
- support of **version sticker** (see below)
- optionally the current version of [Chromium Browser][chromium] open-source web browser (from the `Ubuntu 18.04 LTS` distribution)
- optionally the current version of [Firefox][firefox] web browser and optionally also some additional **plus** features described in the [sibling image README][sibling-readme-xfce-firefox]

All images contain the free open-source bitmap image editor [gimp][gimp] from the `Ubuntu 20.04 LTS` distribution.

The history of notable changes is documented in the [CHANGELOG][this-changelog].

![container-screenshot][this-screenshot-container]

### Image tags

The following image tags on Docker Hub are regularly rebuilt:

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `chromium` adds [Chromium Browser][chromium]

    ![badge_chromium_created][badge_chromium_created]
    [![badge_chromium_version-sticker][badge_chromium_version-sticker]][link_chromium_version-sticker-verbose]

- `firefox` adds [Firefox][firefox] with **plus features** (described in the [sibling image README][sibling-readme-xfce-firefox])

    ![badge_firefox_created][badge_firefox_created]
    [![badge_firefox_version-sticker][badge_firefox_version-sticker]][link_firefox_version-sticker-verbose]

Clicking on the version sticker badge in the [README on Docker Hub][this-readme-dockerhub] reveals more information about the actual configuration of the image.

### Ports

Following **TCP** ports are exposed by default:

- **5901** is used for access over **VNC**
- **6901** is used for access over [noVNC][novnc]

These default ports and also some other parameters can be overridden several ways as it is described in the [sibling image README file][sibling-readme-xfce].

### Volumes

The containers do not create or use any external volumes by default.

Both **named volumes** and **bind mounts** can be used. More about volumes can be found in [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

## Using headless containers

More information about using headless containers can be found in the [full-length README][this-readme-full] file on GitHub.

### Overriding VNC/noVNC parameters

This image supports several ways of overriding the VNC/noVNV parameters. The [sibling image README file][sibling-readme-xfce] describes how to do it.

### Startup options and help

The startup options and help are also described in the [sibling image README file][sibling-readme-xfce].

### More information

More information about these images can be found in the [full-length README][this-readme-full] file on GitHub.

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

<!-- GitHub project common -->

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-drawing-g3/
[this-issues]: https://github.com/accetto/headless-drawing-g3/issues
[this-readme-dockerhub]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3
[this-readme-full]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-gimp/README.md
[this-readme-project]: https://github.com/accetto/headless-drawing-g3/blob/master/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme-project]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-readme-xfce]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce/README.md
[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Docker image specific -->

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3/
[this-dockerfile]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce.drawing

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/ubuntu-vnc-xfce-gimp.jpg

<!-- Previous generations -->

[accetto-github-xubuntu-vnc]: https://github.com/accetto/xubuntu-vnc/
[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- External links -->

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[gimp]: https://www.gimp.org/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[tightvnc]: http://www.tightvnc.com
[tini]: https://github.com/krallin/tini
[xfce]: http://www.xfce.org

<!-- github badges common -->

[badge-github-release]: https://badgen.net/github/release/accetto/headless-drawing-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-drawing-g3?logo=github

<!-- docker badges specific -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-gimp-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-gimp-g3?icon=docker&label=stars

<!-- Appendix -->
