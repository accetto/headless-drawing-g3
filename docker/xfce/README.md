# Headless Ubuntu/Xfce container with VNC/noVNC and OpenGL/WebGL/VirtualGL

## accetto/ubuntu-vnc-xfce-opengl-g3

[Docker Hub][this-docker] - [Git Hub][this-github] - [Dockerfile][this-dockerfile] - [Docker Readme][this-readme-dockerhub] - [Changelog][this-changelog] - [Project Readme][this-readme-project] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment, [VNC][tigervnc]/[noVNC][novnc] servers for headless use.

All images can optionally include the web browsers [Chromium][chromium] or [Firefox][firefox] and also [Mesa3D][mesa3d] libraries and [VirtualGL][virtualgl] toolkit, supporting `OpenGL`, `OpenGL ES`, `WebGL` and other APIs for 3D graphics.

The images with [Mesa3D][mesa3d] include also the OpenGL test applications `glxgears`, `es2gears`, `es2tri` and the OpenGL benchmark [glmark2][glmark2].

These images are intended for experimenting with OpenGL/WebGL support and 3D applications in Docker containers. The best results will be probably achieved with NVidia GPUs and [NVIDIA Container Toolkit][nvidia-container-toolkit]. In other scenarios the [VirtualGL][virtualgl] Toolkit can be used.

### TL;DR

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Ubuntu Packages Search][ubuntu-packages-search] page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```

The fastest way to build the images including Mesa3D/VirtualGL locally:

```shell
### PWD = project root
./docker/hooks/build dev latest
./docker/hooks/build dev vnc-novnc-mesa-vgl
./docker/hooks/build dev vnc-novnc-mesa-chromium
./docker/hooks/build dev vnc-novnc-mesa-firefox
./docker/hooks/build dev vnc-novnc-mesa-vgl-chromium
./docker/hooks/build dev vnc-novnc-mesa-vgl-firefox
./docker/hooks/build dev vnc-mesa
./docker/hooks/build dev vnc-mesa-vgl
### and so on
```

Find more in the hook script `env.rc` and in the [sibling Wiki][sibling-wiki].

Sharing the display with the host (Linux only):

```bash
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-opengl-g3:vnc-mesa --skip-vnc

xhost -local:$(whoami)
```

Sharing the X11 socket with the host (Linux only):

```bash
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-opengl-g3:vnc-novnc-mesa-vgl

xhost -local:$(whoami)

### use VirtualGL inside the container
vglrun glmark2
```

Find more in the section about using OpenGL/WebGL and HW acceleration below and in this [discussion][sibling-discussion-supporting-opengl-and-using-hw-acceleration].

Testing WebGL support in a browser - navigate to [https://get.webgl.org/][webgl-test].

### Table of contents

- [Headless Ubuntu/Xfce container with VNC/noVNC and OpenGL/WebGL/VirtualGL](#headless-ubuntuxfce-container-with-vncnovnc-and-openglwebglvirtualgl)
  - [accetto/ubuntu-vnc-xfce-opengl-g3](#accettoubuntu-vnc-xfce-opengl-g3)
    - [TL;DR](#tldr)
    - [Table of contents](#table-of-contents)
    - [Image tags](#image-tags)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [Version sticker](#version-sticker)
  - [Using headless containers](#using-headless-containers)
    - [Overriding VNC/noVNC parameters](#overriding-vncnovnc-parameters)
    - [Running containers in background or foreground](#running-containers-in-background-or-foreground)
    - [Startup options and help](#startup-options-and-help)
  - [Using OpenGL/WebGL and HW acceleration](#using-openglwebgl-and-hw-acceleration)
    - [Testing WebGL support in browsers](#testing-webgl-support-in-browsers)
    - [Using GPU of the host](#using-gpu-of-the-host)
      - [Sharing display with the host](#sharing-display-with-the-host)
      - [Using VNC and VirtualGL](#using-vnc-and-virtualgl)
    - [Using software rendering](#using-software-rendering)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)
  - [Diagrams](#diagrams)
    - [Dockerfile.xfce](#dockerfilexfce)

This is the **third generation** (G3) of my headless images. More information about the image generations can be found in the [sibling project README][sibling-readme-project] file and the [sibling Wiki][sibling-wiki].

The images are similar to the images created from the sibling GitHub repository [accetto/ubuntu-vnc-xfce-g3][sibling-github], but they can be built to include also the [Mesa3D][mesa3d] and [VirtualGL][virtualgl] libraries.

**Remark:** The images can optionally contain the current `Chromium Browser` version from the `Ubuntu 18.04 LTS` distribution. This is because the version for `Ubuntu 20.04 LTS` depends on `snap`, which is not working correctly in Docker at this time. They can also optionally contain the latest version of the current [Firefox][firefox] browser for `Ubuntu 20.04 LTS`.

**Attention:** If you will build an image containing the [Chromium Browser][chromium], then the browser will run in the `--no-sandbox` mode. You should be aware of the implications. The image is intended for testing and development.

**Attention:** If you will build an image containing the [Firefox][firefox] browser, then the browser will run in the `multi-process` mode. Be aware, that this mode requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the **Firefox multi-process** page in [this Wiki][that-wiki-firefox-multiprocess] for more information and the instructions, how to set the shared memory size in different scenarios.

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
- optionally [Mesa3D][mesa3d] libraries can be included (Ubuntu distribution)
- optionally OpenGL test applications `glxgears`, `es2gears` and `es2tri` (Ubuntu distribution)
- optionally OpenGL benchmark application [glmark2][glmark2] (Ubuntu distribution)
- optionally [VirtualGL][virtualgl] toolkit can be included (latest version)
- optionally the current version of [Chromium Browser][chromium] open-source web browser (from the `Ubuntu 18.04 LTS` distribution)
- optionally the current version of [Firefox][firefox] web browser and optionally also some additional **plus** features described in the [sibling image README][sibling-readme-xfce-firefox]

The history of notable changes is documented in the [CHANGELOG][this-changelog].

![container-screenshot][this-screenshot-container]

### Image tags

The following images will be regularly built and published on Docker Hub:

- base images
  - `latest` is identical to `vnc-novnc-mesa-vgl`
  - `vnc-novnc-mesa` implements VNC, noVNC and Mesa3D
  - `vnc-novnc-mesa-vgl` implements VNC, noVNC, Mesa3D and VirtualGL
  - `vnc-mesa` implements VNC and Mesa3D
  - `vnc-mesa-vgl` implements VNC, Mesa3D and VirtualGL
- adding [Chromium Browser][chromium]
  - `vnc-novnc-mesa-vgl-chromium`
- adding [Firefox][firefox], optionally with the **plus features** (described in the [sibling image README][sibling-readme-xfce-firefox])
  - `vnc-novnc-mesa-vgl-firefox`
  - `vnc-novnc-mesa-vgl-firefox-plus`

The images with other possible combinations of features will not be regularly built or published on Docker Hub, but they can be built any time locally from the same [source repository][this-github].

Clicking on the version sticker badge in the [README on Docker Hub][this-readme-dockerhub] reveals more information about the actual configuration of the image.

### Ports

Following **TCP** ports are exposed by default:

- **5901** is used for access over **VNC**
- **6901** is used for access over [noVNC][novnc]

These default ports and also some other parameters can be overridden several ways as it is described in the [sibling image README file][sibling-readme-xfce].

### Volumes

The containers do not create or use any external volumes by default.

Both **named volumes** and **bind mounts** can be used. More about volumes can be found in [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

### Version sticker

Version sticker serves multiple purposes that are closer described in the [sibling Wiki][sibling-wiki]. Note that the usage of the version sticker has changed between the generations of images.

The **short version sticker value** describes the version of the image and it is persisted in its **label** during the build-time. It is also shown as its **badge** in the README file.

The **verbose version sticker value** is used by the CI builder to decide if the image needs to be refreshed. It describes the actual configuration of the essential components of the image. It can be revealed by clicking on the version sticker badge in the README file.

The version sticker values are generated by the script `version_sticker.sh`, which is deployed into the startup directory `/dockerstartup`. The script will show a short help if executed with the argument `-h`. There is also a convenient `Version Sticker` launcher on the container desktop.

## Using headless containers

There are two ways, how to use the containers created from this image.

All containers are accessible by a VNC viewer (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The default `VNC_PORT` value is `5901`. The default `DISPLAY` value is `:1`. The default VNC password (`VNC_PW`) is `headless`.

The containers that are created from the images built with the **noVNC feature** can be also accessed over [noVNC][noVNC] by any web browser supporting HTML5.

The default `NO_VNC_PORT` value is `6901`. The noVNC password is always identical to the VNC password.

There are several ways of connecting to headless containers and the possibilities also differ between the Linux and Windows environments, but usually it is done by mapping the VNC/noVNC ports exposed by the container to some free TCP ports on its host system.

For example, the following command would map the VNC/noVNC ports `5901/6901` of the container to the TCP ports `25901/26901` on the host:

```shell
docker run -p 25901:5901 -p 26901:6901 ...
```

If the container would run on the local computer, then it would be accessible over **VNC** as `localhost:25901` and over **noVNC** as `http://localhost:26901`.

If it would run on the remote server  `mynas`, then it would be accessible over **VNC** as `mynas:25901` and over **noVNC** as `http://mynas:26901`.

The image offers two [noVNC][novnc] clients - **lite client** and **full client**. Because the connection URL differs slightly in both cases, the container provides a **simple startup page**.

The startup page offers two hyperlinks for both noVNC clients:

- **noVNC Lite Client** (`http://mynas:26901/vnc_lite.html`)
- **noVNC Full Client** (`http://mynas:26901/vnc.html`)

It is also possible to provide the password through the links:

- `http://mynas:26901/vnc_lite.html?password=headless`
- `http://mynas:26901/vnc.html?password=headless`

### Overriding VNC/noVNC parameters

This image supports several ways of overriding the VNC/noVNV parameters. The [sibling image README file][sibling-readme-xfce] describes how to do it.

### Running containers in background or foreground

The [sibling image README file][sibling-readme-xfce] describes how to run the containers in the background (detached) of foreground (interactively).

### Startup options and help

The startup options and help are also described in the [sibling image README file][sibling-readme-xfce].

## Using OpenGL/WebGL and HW acceleration

Support for hardware graphics acceleration in these images is still experimental. The images are intended as the base for experiments with your particular graphics hardware.

For sharing the experience and ideas I've started the discussion [Supporting OpenGL/WebGL and using HW acceleration (GPU)][sibling-discussion-supporting-opengl-and-using-hw-acceleration] in the sibling project [accetto/ubuntu-vnc-xfce-g3][sibling-github]. There are also some links to interesting articles about the subject.

### Testing WebGL support in browsers

Mozilla's [documentation][mozilla-doc-webgl] contains the following description of `WebGL`:

> WebGL (Web Graphics Library) is a JavaScript API for rendering high-performance interactive 3D and 2D graphics within any compatible web browser without the use of plug-ins. WebGL does so by introducing an API that closely conforms to OpenGL ES 2.0 that can be used in HTML5 `<canvas>` elements. This conformance makes it possible for the API to take advantage of hardware graphics acceleration provided by the user's device.

The WebGL support in particular browser can be tested by navigating to [this URL][webgl-test]. You should see a spinning cube.

Interesting enough, [Firefox][firefox] requires the `mesa-utils` to be installed in the container, but [Chromium][chromium] does not.

### Using GPU of the host

Using the GPU of the host is possible only on Linux. The correct usage and the required support is heavily dependent on the particular graphics hardware.

The best results are probably achievable with NVidia hardware and [NVIDIA Container Toolkit][nvidia-container-toolkit]. However, my testing shows, that also ordinary integrated graphics from Intel can improve the performance comparing to pure software rendering.

The following examples show, how to execute the tests. Note that because of the integrated Intel graphics it's necessary to share the device `/dev/dri/card0`.

I've described my test results in [this discussion comment][sibling-discussion-supporting-opengl-and-using-hw-acceleration-test-results].

#### Sharing display with the host

This example shows, how a graphic application encapsulated in a container, can run with high performance by sharing the display with the host.

Start a new container from any of my images that include [Mesa3D][mesa3d]. You don't need the VNC server running inside the container in this case and you should skip its start. If you don't, the container will stop itself.

For example:

```bash
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --name devrun \
    accetto/ubuntu-vnc-xfce-opengl-g3:vnc-mesa --skip-vnc

xhost -local:$(whoami)
```

After the container is running, start the OpenGL benchmark application [glmark2][glmark2] from an another terminal window on the host:

```bash
docker exec -it devrun glmark2
```

You should see a spinning horse and then the other animations of the test. In the terminal window you should see, that your graphics hardware has been recognized correctly. In my particular case it was:

```bash
=======================================================
    glmark2 2014.03+git20150611.fa71af2d
=======================================================
    OpenGL Information
    GL_VENDOR:     Intel
    GL_RENDERER:   Mesa Intel(R) UHD Graphics 620 (KBL GT2)
    GL_VERSION:    4.6 (Compatibility Profile) Mesa 20.2.6
=======================================================
```

If you've got an error, try to allow access for all users by using `xhost +` before starting the container. Don't forget to use `xhost -` after stopping the container.

#### Using VNC and VirtualGL

Even if you want or need to access the containers via VNC/noVNC, you can still benefit from the GPU of the host to some extent. My [test results][sibling-discussion-supporting-opengl-and-using-hw-acceleration-test-results] show, that the performance penalty is significant, but VNC/noVNC access could be more important in some cases.

You will need to use [VirtualGL][virtualgl] to access the graphics hardware of the host, but you don't need to share the display. However, you still need to share the X11 socket.

Start a new container from any of my images that include [Mesa3D][mesa3d] and [VirtualGL][virtualgl].
 For example:

```bash
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/ubuntu-vnc-xfce-opengl-g3:vnc-novnc-mesa-vgl

xhost -local:$(whoami)
```

After the container is running, connect to it using a VNC viewer or from a browser over noVNC. Start the `glmark2` benchmark from a terminal window inside the container using `VirtualGL`:

```bash
vglrun glmark2
```

You should see in the terminal window, that the application is using the graphics hardware of the host (see above). My test results show, that the performance was about 45% higher than by using pure software rendering.

### Using software rendering

If you don't want or can't to share the X11 socket, because you're on Windows, for example, then you can use any of my containers. If you get an error that OpenGL is not available, then use any of the images that include [Mesa3D][mesa3d] libraries.

You can start a new container a usual way and you don't need to care about `xhost`.

For example:

```bash
docker run -it -P --rm accetto/ubuntu-vnc-xfce-opengl-g3:latest
```

After the container is running, connect to it using a VNC viewer or from a browser over noVNC and start the `glmark2` benchmark from a terminal window inside the container:

```bash
glmark2
```

You should see in the terminal window, that the software rendering is used:

```bash
=======================================================
    glmark2 2014.03+git20150611.fa71af2d
=======================================================
    OpenGL Information
    GL_VENDOR:     Mesa/X.org
    GL_RENDERER:   llvmpipe (LLVM 11.0.0, 256 bits)
    GL_VERSION:    3.1 Mesa 20.2.6
=======================================================
```

Despite the lower performance, the `glmark2` benchmark should finish successfully.

Also the OpenGL test applications `glxgears`, `es2gears` and `es2tri` should run sucessfully.

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

## Diagrams

### Dockerfile.xfce

![Dockerfile.xfce stages][this-diagram-dockerfile-stages-xfce]

***

<!-- GitHub project common -->

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-drawing-g3/
[this-issues]: https://github.com/accetto/headless-drawing-g3/issues
[this-readme-dockerhub]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-opengl-g3
[this-readme-project]: https://github.com/accetto/headless-drawing-g3/blob/master/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-discussion-supporting-opengl-and-using-hw-acceleration]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions/10
[sibling-discussion-supporting-opengl-and-using-hw-acceleration-test-results]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions/10#discussioncomment-773317

[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme-project]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-readme-xfce]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce/README.md
[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Docker image specific -->

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-opengl-g3/
[this-dockerfile]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce.drawing

[this-diagram-dockerfile-stages-xfce]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/Dockerfile.xfce.png
[this-diagram-dockerfile-stages-drawing]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/Dockerfile.xfce.png

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/ubuntu-vnc-xfce-opengl.jpg

<!-- Previous generations -->

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- External links -->

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[mozilla-doc-webgl]: https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[glmark2]: https://github.com/glmark2/glmark2
[jq]: https://stedolan.github.io/jq/
[mesa3d]: https://mesa3d.org/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[nvidia-container-toolkit]: https://github.com/NVIDIA/nvidia-docker
[tigervnc]: http://tigervnc.org
[tightvnc]: http://www.tightvnc.com
[tini]: https://github.com/krallin/tini
[virtualgl]: https://virtualgl.org/About/Introduction
[webgl-test]: https://get.webgl.org/
[xfce]: http://www.xfce.org

<!-- github badges common -->

[badge-github-release]: https://badgen.net/github/release/accetto/headless-drawing-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-drawing-g3?logo=github

<!-- docker badges specific -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-opengl-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-opengl-g3?icon=docker&label=stars
