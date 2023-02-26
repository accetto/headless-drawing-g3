# Headless Ubuntu/Xfce containers with VNC/noVNC for diagramming, image editing and 2D/3D drawing

## Project `accetto/headless-drawing-g3`

Version: G3v2

***

[Docker Hub][this-docker] - [Changelog][this-changelog] - [sibling Wiki][sibling-wiki] - [sibling Discussions][sibling-discussions]

![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]
![badge-github-stars][badge-github-stars]
![badge-github-forks][badge-github-forks]
![badge-github-open-issues][badge-github-open-issues]
![badge-github-closed-issues][badge-github-closed-issues]
![badge-github-releases][badge-github-releases]
![badge-github-commits][badge-github-commits]
![badge-github-last-commit][badge-github-last-commit]

<!-- ![badge-github-workflow-dockerhub-autobuild][badge-github-workflow-dockerhub-autobuild] -->
<!-- ![badge-github-workflow-dockerhub-post-push][badge-github-workflow-dockerhub-post-push] -->

***

- [Headless Ubuntu/Xfce containers with VNC/noVNC for diagramming, image editing and 2D/3D drawing](#headless-ubuntuxfce-containers-with-vncnovnc-for-diagramming-image-editing-and-2d3d-drawing)
  - [Project `accetto/headless-drawing-g3`](#project-accettoheadless-drawing-g3)
  - [Introduction](#introduction)
  - [TL;DR](#tldr)
      - [Installing packages](#installing-packages)
      - [Shared memory size](#shared-memory-size)
      - [Extending images](#extending-images)
      - [Building images](#building-images)
      - [Sharing devices](#sharing-devices)
  - [Project versions](#project-versions)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)

## Introduction

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use and selected applications for diagramming, vector drawing and bitmap image editing.

All images can optionally include the web browsers [Chromium][chromium] or [Firefox][firefox] and also [Mesa3D][mesa3d] libraries and [VirtualGL][virtualgl] toolkit, supporting `OpenGL`, `OpenGL ES`, `WebGL` and other APIs for 3D graphics.

The resources for the individual images and their variations (tags) are stored in the subfolders of the **master** branch. Each image has its own README file describing its features and usage.

This is a sibling project to the project [accetto/ubuntu-vnc-xfce-g3][sibling-github], which contains the detailed description of the third generation (G3) of my Docker images. Please check the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki] for common information.

**Deprecating `FreeCAD`**

The image featuring the `FreeCAD` is **deprecated** and it will be re-designed sometimes in the future. The reason is, that it's really huge and that its deployment pattern does not really fit. You can still build the image containing the `FreeCAD` version **0.19.3**, but the image will be excluded from the examples and from the `complete` group used by the utility `ci-builder.sh`. Be also aware, that downloading `FreeCAD` will take considerable time.

## TL;DR

There are currently resources for the following Docker images:

- [accetto/ubuntu-vnc-xfce-opengl-g3][accetto-docker-ubuntu-vnc-xfce-opengl-g3]
  - [full Readme][this-readme-image-opengl]
  - [Dockerfile][this-dockerfile-xfce]
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-xfce]
- [accetto/ubuntu-vnc-xfce-blender-g3][accetto-docker-ubuntu-vnc-xfce-blender-g3]
  - [full Readme][this-readme-image-blender]
  - [Dockerfile][this-dockerfile-drawing] (common for all the following images)
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-drawing] (common for all the following images)
- [accetto/ubuntu-vnc-xfce-drawio-g3][accetto-docker-ubuntu-vnc-xfce-drawio-g3]
  - [full Readme][this-readme-image-drawio]
- [accetto/ubuntu-vnc-xfce-freecad-g3][accetto-docker-ubuntu-vnc-xfce-freecad-g3]
  - [full Readme][this-readme-image-freecad]
- [accetto/ubuntu-vnc-xfce-gimp-g3][accetto-docker-ubuntu-vnc-xfce-gimp-g3]
  - [full Readme][this-readme-image-gimp]
- [accetto/ubuntu-vnc-xfce-inkscape-g3][accetto-docker-ubuntu-vnc-xfce-inkscape-g3]
  - [full Readme][this-readme-image-inkscape]

#### Installing packages

I try to keep the images slim. Consequently you can sometimes encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Ubuntu Packages Search][ubuntu-packages-search] page and install them subsequently.

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
### and also replacing 'latest' by 'blender|drawio|gimp|inkscape'
### (or also by 'freecad' if you really wish so)
./builder.sh latest all
./builder.sh latest-chromium all
./builder.sh latest-firefox all

### or skipping the publishing to the Docker Hub
./builder.sh latest all-no-push
./builder.sh latest-chromium all-no-push
./builder.sh latest-firefox all-no-push

### example of building and publishing a group of images
./ci-builder.sh all group latest blender drawio drawio-chromium inkscape-firefox

### or all the images at once (excluding 'freecad')
./ci-builder.sh all group complete

### or skipping the publishing to the Docker Hub
./ci-builder.sh all-no-push group complete

### or all images featuring 'Chromium Browser' or 'Firefox' (excluding 'freecad')
./ci-builder.sh all group complete-chromium
./ci-builder.sh all group complete-firefox

### or, for example, complete 'drawio' or 'inkscape' group
./ci-builder.sh all group complete-drawio
./ci-builder.sh all group complete-inkscape

### and so on
```

You can still execute the individual hook scripts as before (see the folder `/docker/hooks/`). However, the provided utilities `builder.sh` and `ci-builder.sh` are more convenient. Before pushing the images to the **Docker Hub** you have to prepare and source the file `secrets.rc` (see `example-secrets.rc`). The script `builder.sh` builds the individual images. The script `ci-builder.sh` can build various groups of images or all of them at once. Check the files `local-builder-readme.md`, `local-building-example.md` and the [sibling Wiki][sibling-wiki] for more information.

#### Sharing devices

Sharing the audio device for video with sound works only with `Chromium` and only on Linux:

```shell
docker run -it -P --rm \
  --device /dev/snd:/dev/snd:rw \
  --group-add audio \
accetto/ubuntu-vnc-xfce-opengl-g3:chromium
```

Sharing the display with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-opengl-g3:latest --skip-vnc

xhost -local:$(whoami)
```

Sharing the X11 socket with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-opengl-g3:latest

xhost -local:$(whoami)
```

## Project versions

This file describes the **second version** (G3v2) of the project.

The **first version** (G3v1, or simply G3) will still be available in this **GitHub** repository as the branch `archived-generation-g3v1`.

The version `G3v2` brings the following major changes comparing to the previous version `G3v1`:

- Significantly improved building performance by introducing a local cache (`g3-cache`).
- Auto-building on the **Docker Hub** and using of the **GitHub Actions** have been abandoned.
- The enhanced building pipeline moves towards building the images outside the **Docker Hub** and aims to support also stages with CI/CD capabilities (e.g. the **GitLab**).
- The **local stage** is the default building stage now. However, the new building pipeline has already been tested also with a local **GitLab** installation in a Docker container on a Linux machine.
- Automatic publishing of README files to the **Docker Hub** has been removed, because it was not working properly any more. However, the README files for the **Docker Hub** can still be prepared with the provided utility `util-readme.sh` and then copy-and-pasted to the **Docker Hub** manually.

The changes affect only the building pipeline, not the Docker images themselves. The `Dockerfile`, apart from using the new local `g3-cache`, stays conceptually unchanged.

You can learn more about the project generations in the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki].

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

<!-- this project -->

[this-docker]: https://hub.docker.com/u/accetto/

[this-dockerfile-xfce]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce
[this-dockerfile-drawing]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce.drawing

[this-readme-image-opengl]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce/README.md
[this-readme-image-blender]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-blender/README.md
[this-readme-image-drawio]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-drawio/README.md
[this-readme-image-freecad]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-freecad/README.md
[this-readme-image-gimp]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-gimp/README.md
[this-readme-image-inkscape]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-inkscape/README.md

[accetto-docker-ubuntu-vnc-xfce-opengl-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-opengl-g3
[accetto-docker-ubuntu-vnc-xfce-blender-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-blender-g3
[accetto-docker-ubuntu-vnc-xfce-drawio-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-drawio-g3
[accetto-docker-ubuntu-vnc-xfce-freecad-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-freecad-g3
[accetto-docker-ubuntu-vnc-xfce-gimp-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3
[accetto-docker-ubuntu-vnc-xfce-inkscape-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-inkscape-g3

<!-- diagrams -->

[this-diagram-dockerfile-stages-xfce]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/Dockerfile.xfce.png
[this-diagram-dockerfile-stages-drawing]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/Dockerfile.xfce.drawing.png

<!-- sibling project -->

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-drawing-g3/
[this-issues]: https://github.com/accetto/headless-drawing-g3/issues

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Previous generations -->

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- external links -->

[ubuntu-packages-search]: https://packages.ubuntu.com/

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[blender]: https://www.blender.org/
[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[mesa3d]: https://mesa3d.org/
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[virtualgl]: https://virtualgl.org/About/Introduction
[xfce]: http://www.xfce.org

<!-- github badges -->

[badge-github-workflow-dockerhub-autobuild]: https://github.com/accetto/headless-drawing-g3/workflows/dockerhub-autobuild/badge.svg

[badge-github-workflow-dockerhub-post-push]: https://github.com/accetto/headless-drawing-g3/workflows/dockerhub-post-push/badge.svg

[badge-github-release]: https://badgen.net/github/release/accetto/headless-drawing-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-drawing-g3?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/headless-drawing-g3?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/headless-drawing-g3?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/headless-drawing-g3?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/headless-drawing-g3?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/headless-drawing-g3?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/headless-drawing-g3?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/headless-drawing-g3?icon=github&label=open%20issues
