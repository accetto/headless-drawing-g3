# CHANGELOG

## Project `accetto/headless-drawing-g3`

[User Guide][this-user-guide] - [Docker Hub][this-docker] - [Git Hub][this-github] - [sibling Wiki][sibling-wiki] - [sibling Discussions][sibling-discussions]

***

### Release 24.02.1

This is a fixed maintenance release.
FreeCAD has changed assets naming.

Updated applications:

- `FreeCAD` to version **0.21.2**

### Release 24.02 (!)

**Warning!**
FreeCAD in this release doesn't work!
Please use the next release.

This is a maintenance release.
FreeCAD has changed assets naming.

### Release 23.12

This is a maintenance release.

- Fixed script `version_of`
  - new way to get the latest `VirtualGL` version number
- Updated Dockerfiles
  - file `.bashrc` is created earlier (stage `merge_stage_vnc`)
- Updated file `example-secrets.rc`
  - removed the initialization of the variables `FORCE_BUILDING` and `FORCE_PUBLISHING_BUILDER_REPO` (unset means `0`)
  - the variables are still used as before, but now they can be set individually for each building/publishing run

### Release 23.11

- Added file `$HOME/.bashrc` to all images.
It contains examples of custom aliases
  - `ll` - just `ls -l`
  - `cls` - clears the terminal window
  - `ps1` - sets the command prompt text

- Added more 'die-fast' error handling into the building and publishing scripts.
They exit immediately if the image building or pushing commands fail.

### Release 23.08.1

Main changes:

- hook scripts `env.rc`, `push` and `post_push` have been updated
- handling of multiple deployment tags per image has been improved and it covers also publishing into the builder repository now
  - also less image pollution by publishing
- file `readme-local-building-example.md` got a new section `Tips and examples`, containing
  - `How to deploy all images into one repository`
- fix in `ci-builder.sh` help mode
- readme files updated

### Release 23.08

This release brings updated and significantly shortened README files, because most of the content has been moved into the new [User guide][this-user-guide].

Updated applications:

- `FreeCAD` to version **0.21.0**
- `Inkscape` to version **1.3**

### Release 23.07.1

This release brings some enhancements in the Dockerfiles and the script `user_generator.rc` with the aim to better support extending the images.

### Release 23.07

This release introduces a new feature `FEATURES_OVERRIDING_ENVV`, which controls the overriding or adding of environment variables at the container startup-time.
Meaning, after the container has already been created.

The feature is enabled by default.
It can be disabled by setting the variable `FEATURES_OVERRIDING_ENVV` to zero when the container is created or the image is built.
Be aware that any other value than zero, even if unset or empty, enables the feature.

If `FEATURES_OVERRIDING_ENVV=1`, then the container startup script will look for the file `$HOME/.override/.override_envv.rc` and source all the lines that begin with the string 'export ' at the first position and contain the '=' character.

The overriding file can be provided from outside the container using *bind mounts* or *volumes*.

The lines that have been actually sourced can be reported into the container's log if the startup parameter `--verbose` or `--debug` is provided.

This feature is an enhanced implementation of the previously available functionality known as **Overriding VNC/noVNC parameters at the container startup-time**.

Therefore this is a **breaking change** for the users that already use the VNC/noVNC overriding.
They need to move the content from the previous file `$HOME"/.vnc_override.rc` into the new file `$HOME/.override/.override_envv.rc`.

Other changes:

- Updated script `ci-builder.sh`:
  - groups `pivotal|complete|complete-chromium|complete-firefox` do not include the `blender` and `freecad` images because of their size and upload time

### Release 23.04.1

`FreeCAD` is back in its current version **0.20.2** and the image based on `Ubuntu 22.04 LTS`.

### Release 23.04

Fixing a bug in the Dockerfile's **stage_freecad** of the archived branch `archived-generation-g3v2`. The new archived branch name is `archived-generation-g3v2-fix`.

Updated components (archived branch):

- `TigerVNC` to version **1.13.1**
- `noVNC` to version **1.4.0**
- `VirtualGL` to version **3.1**
- `Chromium Browser` to version **111.0.5563.64**
- `Firefox` to version **111.0.1**

### Release 23.03.1

This release mitigates the problems with the edge use case, when users bind the whole `$HOME` directory to an external folder on the host computer.

Please note that I recommend to avoid doing that. If you really want to, then your best bet is using the Docker volumes. That is the only option I've found, which works across the environments. In the sibling discussion thread [#39](https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions/39) I've described the way, how to initialize a bound `$HOME` folder, if you really want to give it a try.

Main changes:

- file `.initial_sudo_password` has been moved from the `$HOME` to the `$STARTUPDIR` folder
- file `.initial_sudo_password` is not deleted, but cleared after the container user is created
- startup scripts have been adjusted and improved
- readme files have been updated

### Release 23.03

This is the first `G3v3` release, switching the images from `Ubuntu 20.04 LTS` to `Ubuntu 22.04 LTS` and introducing the updated startup scripts. The previous version `G3v2` will still be available in this repository as the branch `archived-generation-g3v2`.

The image featuring `FreeCAD` has been removed from this project. It will come back sometimes in the future, possibly as a stand-alone project. You can still download images containing `FreeCAD v0.19.3` from the **Docker Hub** repository [accetto/ubuntu-vnc-xfce-freecad-g3][accetto-docker-ubuntu-vnc-xfce-freecad-g3].

This release corresponds to the version `G3v4` of the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] (as of the release `23.03.1`).

The updated startup scripts that support overriding the user ID (`id`) and group ID (`gid`) without needing the former build argument `ARG_FEATURES_USER_GROUP_OVERRIDE`, which has been removed.

- The user ID and the group ID can be overridden during the build time (`docker build`) and the run time (`docker run`).
- The `user name`, the `group name` and the `initial sudo password` can be overridden during the build time.
- The permissions of the files `/etc/passwd` and `/etc/groups` are set to the standard `644` after creating the user.
- The content of the home folder and the startup folder belongs to the created user.
- The created user gets permissions to use `sudo`. The initial `sudo` password is configurable during the build time using the build argument `ARG_SUDO_INITIAL_PW`. The password can be changed inside the container.
- The default `id:gid` has been changed from `1001:0` to `1000:1000`.

Features `NOVNC` and `FIREFOX_PLUS`, that are enabled by default, can be disabled via environment variables:

- If `FEATURES_NOVNC="0"`, then
  - image will not include `noVNC`
  - image tag will get the `-vnc` suffix (e.g. `latest-vnc` etc.)
- If `FEATURES_FIREFOX_PLUS="0"` and `FEATURES_FIREFOX="1"`, then
  - image with Firefox will not include the *Firefox Plus features*
  - image tag will get the `-default` suffix (e.g. `latest-firefox-default` or also `latest-firefox-default-vnc` etc.)

Changes in build arguments:

- removed `ARG_FEATURES_USER_GROUP_OVERRIDE`
- renamed `ARG_SUDO_PW` to `ARG_SUDO_INITIAL_PW`
- added `ARG_HEADLESS_USER_ID`, `ARG_HEADLESS_USER_NAME`, `ARG_HEADLESS_USER_GROUP_ID` and `ARG_HEADLESS_USER_GROUP_NAME`

Changes in environment variables:

- removed `FEATURES_USER_GROUP_OVERRIDE`
- added `HEADLESS_USER_ID`, `HEADLESS_USER_NAME`, `HEADLESS_USER_GROUP_ID` and `HEADLESS_USER_GROUP_NAME`

Main changes in files:

- updated `Dockerfile.xfce.nodejs`, `Dockerfile.xfce.postman` and `Dockerfile.xfce.python`
- updated `startup.sh`, `user_generator.rc` and `set_user_permissions.sh`
- updated hook scripts `env.rc`, `build`, `pre_build` and `util.rc`
- added `tests/test-01.sh` allows to quickly check the current permissions

Updated versions:

- **TigerVNC** to version `1.13.1`
- **noVNC** to version `1.4.0`
- **Blender** to version `3.0.1` (Ubuntu distribution)
- **Gimp** to version `2.10.30` (Ubuntu distribution)

Removed applications/images:

- **FreeCAD** version `0.19.3`

### Release 22.12.1

- Updated components:

  - **websockify** to version **0.11.0**

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

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-docker]: https://hub.docker.com/u/accetto/

[this-github]: https://github.com/accetto/headless-drawing-g3/

[accetto-docker-ubuntu-vnc-xfce-freecad-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-freecad-g3

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

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
