# Headless Ubuntu/Xfce containers with VNC/noVNC for diagramming, vector drawing and bitmap image editing

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

![badge-github-workflow-dockerhub-autobuild][badge-github-workflow-dockerhub-autobuild]
![badge-github-workflow-dockerhub-post-push][badge-github-workflow-dockerhub-post-push]

***

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use and selected applications for diagramming, vector drawing and bitmap image editing. All images can optionally include also the web browsers [Chromium][chromium] or [Firefox][firefox].

The resources for the individual images and their variations (tags) are stored in the subfolders of the **master** branch. Each image has its own README file describing its features and usage.

This is a sibling project to the project [accetto/ubuntu-vnc-xfce-g3][sibling-github], which contains the detailed description of the third generation (G3) of my Docker images. Please check the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki] for common information.

## TL;DR

There are currently resources for the following Docker images:

- [accetto/ubuntu-vnc-xfce-drawio-g3][accetto-docker-ubuntu-vnc-xfce-drawio-g3]
- [accetto/ubuntu-vnc-xfce-gimp-g3][accetto-docker-ubuntu-vnc-xfce-gimp-g3]
- [accetto/ubuntu-vnc-xfce-inkscape-g3][accetto-docker-ubuntu-vnc-xfce-inkscape-g3]

The fastest way to build the images locally:

```shell
### PWD = project root
./docker/hooks/build dev latest-drawio
./docker/hooks/build dev latest-gimp
./docker/hooks/build dev latest-inkscape
```

Find more in the hook script `env.rc` and in the [sibling Wiki][sibling-wiki].

## Bonus base images

This project contains also resources for building the base images without the diagramming, drawing or image editing applications. Because those images would be actually equivalent to the images from the [sibling project][sibling-github], they will not be built or published on Docker Hub. However, you can build them yourself locally any time you wish.

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

[this-docker]: https://hub.docker.com/u/accetto/

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-drawing-g3/
[this-issues]: https://github.com/accetto/headless-drawing-g3/issues

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[accetto-docker-ubuntu-vnc-xfce-drawio-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-drawio-g3
[accetto-docker-ubuntu-vnc-xfce-gimp-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3
[accetto-docker-ubuntu-vnc-xfce-inkscape-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-inkscape-g3

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
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
