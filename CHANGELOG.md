# CHANGELOG

## Project `accetto/headless-drawing-g3`

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

***

### Release 22.12

This is a maintenance release.

- README files have been updated
- Folder `examples/` has been moved up to the project's root folder
  - New example `Dockerfile.extended` shows how to use the images as the base of new images
  - New compose file `example.yml` shows how to switch to another non-root user and how to set the VNC password and resolution

### Release 22.11.2

This is a quick fix release for the images featuring `FreeCAD`. The version is locked to `v0.19.3`.


### Release 22.11.1

This is a quick fix release, because the `Chromium Browser` has changed its package naming pattern.

### Release 22.11 (Milestone)

This is a milestone release. It's the first release of the new building pipeline version `G3v2`. The previous version `G3v1` will still be available in this repository as the branch `archived-generation-g3v1`.

The version `G3v2` brings the following major changes:

- Significantly improved building performance by introducing a local cache (`g3-cache`).
- Auto-building on the **Docker Hub** and using of the **GitHub Actions** have been abandoned.
- The enhanced building pipeline moves towards building the images outside the **Docker Hub** and aims to support also stages with CI/CD capabilities (e.g. **GitLab**).
- The **local stage** is the default building stage. The new building pipeline has already been tested also with a local **GitLab** installation in a Docker container on a Linux machine.
- Automatic publishing of README files to the **Docker Hub** has been removed, because it hasn't work properly any more. However, the README files can be still prepared with the provided utility and then copy-and-pasted to the **Docker Hub** manually.
- The image featuring `FreeCAD` is **deprecated**. See the project's README file for the explanation. However, the image containing the `FreeCAD` version **0.19.3** can still be built.

Added files:

- `docker/hooks/cache`
- `ci-builder.sh`
- `readme-builder.md`
- `readme-ci-builder.md`
- `readme-g3-cache.md`
- `readme-local-building-example.md`
- `utils/readme-util-readme-examples.md`

Removed files:

- `local-builder-readme.md`
- `local-building-example.md`
- `utils/example-secrets-utils.rc`
- `utils/examples-util-readme.md`
- `.github/workflows/dockerhub-autobuild.yml`
- `.github/workflows/dockerhub-post-push.yml`
- `.github/workflows/deploy-readme.sh`

Many other files have been updated, some of them significantly.

Hoverer, the changes affect only the building pipeline, not the Docker images themselves. The `Dockerfile`, apart from using the new local `g3-cache`, stays conceptually unchanged.

### Release 22.10 (Milestone)

This is the last release of the current building pipeline generation `G3v1`, which will still be available in the repository as the branch `archived-generation-g3v1`.

The next milestone release will bring some significant changes and improvements in the building pipeline (generation `G3v2`) . The changing parts marked as `DEPRECATED` will be replaced or removed.

### Release 22.09

This is just a maintenance release.

- Warnings about the *README publishing not always working* problem have been added.
- Some comments have been updated.

### Release 22.04

- **noVNC** improvements

  - **noVNC** got a new optional argument, which is passed through a new environment variable **NOVNC_HEARTBEAT**
  
    - set the variable by creating the container, like `docker run -e NOVNC_HEARTBEAT=30` for the ping interval 30 seconds
    - it should prevent disconnections because of inactivity, if the container is used behind load-balancers or reverse proxies ([issue #23](https://github.com/accetto/ubuntu-vnc-xfce-g3/issues/23))

  - script `vnc_startup.rc` has been adjusted and improved
  - script `version_of.sh` has been adjusted
  - **numpy** module has been added to make the HyBi protocol faster

  - following variables related to **noVNC** has been renamed in all related files
    - `ARG_NO_VNC_PORT` renamed to `ARG_NOVNC_PORT`
    - `NO_VNC_HOME` renamed to `NOVNC_HOME`
    - `NO_VNC_PORT` renamed to `NOVNC_PORT`

### Release 22.02

- Updated components:

  - **TigerVNC** to version **1.12.0**
  - **noVNC** to version **1.3.0**
  - **websockify** to version **0.10.0**

- Added components:

  - **python3** (also added into the `verbose version sticker`)
  - **systemctl**

- Updated files:

  - `Dockerfile.xfce` (components updated and added)
  - `Dockerfile.xfce.drawing` (components updated and added)
  - `vnc_startup.rc` (new **noVNC** startup)
  - `version_sticker.sh` (**python3** included)
  - `env.rc` (handling of tags)
  - `build` (handling of tags)
  - `pre_build` (handling of tags)
  - `util-readme.sh` (fixed token parsing)
  - all readme files

- Added files:

  - `local-builder-readme.md`

- Changes in building and publishing policy:

  - The images without **noVNC** will not be published on Docker Hub any more, because the size difference is now only 2MB. However, they always can be built locally.
  - The images tagged `latest` will always implement **VNC** and **noVNC**.
  - The Firefox images will always include also *Firefox plus features*. They do not change the default Firefox installation in any way and you can simply ignore them, if you wish.
  - The base images (*accetto/ubuntu-vnc-xfce-opengl-g3*) without **Mesa3D** and **VirtualGL** will not be published on Docker Hub any more. They can still be built locally after minor adjustments in the hook script `env.rc`.
  - The **Mesa3D** and **VirtualGL** libraries will be always implemented by the **Blender** and **FreeCAD** images.

### Release 22.01.1

- IMPROVED: **Inkscape** on **Unraid** seems to require the environment variable `_INKSCAPE_GC=disable` (issue [#2](https://github.com/accetto/headless-drawing-g3/issues/2))

### Release 22.01

- Dockerfiles use **TigerVNC** releases from **SourceForge** website

### Release 21.10

- `builder.sh` utility accepts additional parameters
- local building example updated

### Release 21.08

- `builder.sh` utility added
  - see also `local-building-example.md`

### Release 21.07

- Docker Hub has removed auto-builds from free plans since 2021-07-26, therefore
  - both GitHub Actions workflows `dockerhub-autobuild.yml` and `dockerhub-post-push.yml` have been disabled because they are not needed on free plans any more
    - just re-enable them if you are on a higher plan
  - **if you stay on the free plan**, then
    - you can still build the images locally and then push them to Docker Hub
      - pushing to Docker Hub is optional
      - just follow the added file `local-building-example.md`
    - you can publish the `readme` files to Docker Hub using the utility `util-readme.sh`
      - just follow the added file `examples-util-readme.md`
  - regularity of updates of images on Docker Hub cannot be guaranteed any more
- Other `Xfce4` related changes since the last release
  - keyboard layout explicit config added
  - `xfce4-terminal` set to unicode `utf-8` explicitly

### Release 21.05.4

- **xfce-freecad** added, into [accetto/ubuntu-vnc-xfce-freecad-g3][accetto-ubuntu-vnc-xfce-freecad-g3]
  - all **FreeCAD** images published on Docker Hub include the same 3D stuff as described by the previous release
  - **Dockerfile.xfce.drawing** file, the stages diagram and the hook scripts updated accordingly

### Release 21.05.3

- **xfce** images added, into [accetto/ubuntu-vnc-xfce-opengl-g3][accetto-ubuntu-vnc-xfce-opengl-g3]
  - introducing **OpenGL/WebGL/VirtualGL** experimental support
  - through [Mesa3D][mesa3d] libraries and [VirtualGL][virtualgl] toolkit
  - OpenGL benchmark [glmark2][glmark2] and the test applications `glxgears`, `es2gears` and `es2tri` are also included
- all **Blender** images published on Docker Hub include the same 3D stuff
- **Dockerfile.xfce**, **Dockerfile.xfce.drawing**, the stages diagrams and the hook scripts have been accordingly updated

### Release 21.05.2

- **Dockerfile stage diagrams** added (see the readme files)
- all images moved to `docker/doc/images`

### Release 21.05.1

- packages **dconf-editor** and **gdebi-core** have been removed

### Release 21.05

- **xfce-blender** added, into [accetto/ubuntu-vnc-xfce-blender-g3][accetto-ubuntu-vnc-xfce-blender-g3]
- images with **Chromium** and **Firefox** will be also regularly built on Docker Hub
- circumventing limit of 25 auto-builder rules on Docker Hub
  - using two builder repositories
  - workflow `dockerhub-autobuild.yml` triggers both of them
  - see also updated [sibling project Wiki][sibling-wiki] (pages  [Building stages][sibling-wiki-building-stages] and [How CI works][sibling-wiki-how-ci-works])

### Release 21.04

- TigerVNC from [Release Mirror on accetto/tigervnc][accetto-tigervnc-release-mirror] because **Bintray** is closing on 2021-05-01

### Release 21.03.2

- hook script `post_push` has been improved
  - environment variable `PROHIBIT_README_PUBLISHING` can be used to prevent the publishing of readme file to Docker Hub deployment repositories
  - useful for testing on Docker Hub or by building from non-default branches

### Release 21.03.1

- **xfce-drawio** Dockerfile adjusted to changed `draw.io Desktop` packaging

### Release 21.03

- Initial release
  - **xfce-drawio** into [accetto/ubuntu-vnc-xfce-drawio-g3][accetto-ubuntu-vnc-xfce-drawio-g3]
  - **xfce-gimp** into [accetto/ubuntu-vnc-xfce-gimp-g3][accetto-ubuntu-vnc-xfce-gimp-g3]
  - **xfce-inkscape** into [accetto/ubuntu-vnc-xfce-inkscape-g3][accetto-ubuntu-vnc-xfce-inkscape-g3]
  - **xfce** image is not built or published on Docker Hub by default

***

[this-docker]: https://hub.docker.com/u/accetto/
[this-github]: https://github.com/accetto/headless-drawing-g3/

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki
[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki-building-stages]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/Building-stages
[sibling-wiki-how-ci-works]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/How-CI-works

[accetto-ubuntu-vnc-xfce-blender-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-blender-g3
[accetto-ubuntu-vnc-xfce-drawio-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-drawio-g3
[accetto-ubuntu-vnc-xfce-freecad-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-freecad-g3
[accetto-ubuntu-vnc-xfce-gimp-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3
[accetto-ubuntu-vnc-xfce-inkscape-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-inkscape-g3
[accetto-ubuntu-vnc-xfce-opengl-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-opengl-g3

[accetto-tigervnc-release-mirror]: https://github.com/accetto/tigervnc/releases

[glmark2]: https://github.com/glmark2/glmark2
[mesa3d]: https://mesa3d.org/
[virtualgl]: https://virtualgl.org/About/Introduction
