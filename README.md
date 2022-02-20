# Headless Ubuntu/Xfce containers with VNC/noVNC for diagramming, image editing and 2D/3D drawing

## Project `accetto/headless-drawing-g3`

***

[Docker Hub][this-docker] - [Changelog][this-changelog] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

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

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use and selected applications for diagramming, vector drawing and bitmap image editing.

All images can optionally include the web browsers [Chromium][chromium] or [Firefox][firefox] and also [Mesa3D][mesa3d] libraries and [VirtualGL][virtualgl] toolkit, supporting `OpenGL`, `OpenGL ES`, `WebGL` and other APIs for 3D graphics.

The resources for the individual images and their variations (tags) are stored in the subfolders of the **master** branch. Each image has its own README file describing its features and usage.

This is a sibling project to the project [accetto/ubuntu-vnc-xfce-g3][sibling-github], which contains the detailed description of the third generation (G3) of my Docker images. Please check the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki] for common information.

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

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Ubuntu Packages Search][ubuntu-packages-search] page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```

The fastest way to build the images locally:

```shell
### PWD = project root
./docker/hooks/build dev latest
./docker/hooks/build dev latest-chromium
./docker/hooks/build dev latest-firefox
./docker/hooks/build dev blender
./docker/hooks/build dev blender-chromium
./docker/hooks/build dev blender-firefox
./docker/hooks/build dev drawio
./docker/hooks/build dev drawio-chromium
./docker/hooks/build dev drawio-firefox
./docker/hooks/build dev freecad
./docker/hooks/build dev freecad-chromium
./docker/hooks/build dev freecad-firefox
./docker/hooks/build dev gimp
./docker/hooks/build dev gimp-chromium
./docker/hooks/build dev gimp-firefox
./docker/hooks/build dev inkscape
./docker/hooks/build dev inkscape-chromium
./docker/hooks/build dev inkscape-firefox
./docker/hooks/build dev vnc
./docker/hooks/build dev vnc-chromium
./docker/hooks/build dev vnc-firefox
./docker/hooks/build dev blender-vnc
./docker/hooks/build dev blender-vnc-chromium
./docker/hooks/build dev blender-vnc-firefox
and so on...
```

You can also use the provided helper script `builder.sh`, which can also publish the images on Docker Hub, if you correctly set the required environment variables (see the file `example-secrets.rc`). Check the files `local-builder-readme.md` and `local-building-example.md`.

Find more in the hook script `env.rc` and in the [sibling Wiki][sibling-wiki].

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
