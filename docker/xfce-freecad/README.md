# Headless Ubuntu/Xfce container with VNC/noVNC and `FreeCAD`

## accetto/ubuntu-vnc-xfce-freecad-g3

[User Guide][this-user-guide] - [Docker Hub][this-docker] - [Dockerfile][this-dockerfile] - [Readme][this-readme] - [Changelog][this-changelog]

***

This GitHub project folder contains resources used by building Debian images available on Docker Hub in the repository [accetto/ubuntu-vnc-xfce-freecad-g3][this-docker].

This [User guide][this-user-guide] describes the images and how to use them.

### Building images

```shell
### PWD = project root
### prepare and source the 'secrets.rc' file first (see 'example-secrets.rc')

### examples of building and publishing the individual images
./builder.sh freecad all
./builder.sh freecad-chromium all
./builder.sh freecad-firefox all

### just building the image, skipping the publishing and the version sticker update
./builder.sh freecad build

### examples of building and publishing the images as a group
./ci-builder.sh all group freecad freecad-firefox

### or all the 'accetto/ubuntu-vnc-xfce-freecad-g3' images
./ci-builder.sh all group complete-freecad
```

Refer to the main [README][this-readme] file for more information about the building subject.

### Remarks

The FreeCAD's AppImage archive size is about 950MB, so the download during the image building can take some time.
Don't interrupt the building process prematurely.

Also the application launch in the running container can take a few seconds, because the AppImage archive file must be extracted first.
Similarly, there are a few seconds for cleaning things up after the application is closed.

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

### Getting help

If you've found a problem or you just have a question, please check the [User guide][this-user-guide], [Issues][this-issues] and sibling [Wiki][sibling-wiki] first.
Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue.
The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can also use the [sibling Discussions][sibling-discussions].

### Diagrams

Diagram of the multi-staged Dockerfile used for building multiple images.

The actual content of a particular image build is controlled by the *feature variables*.

![Dockerfile.xfce.drawing stages][this-diagram-dockerfile-stages-drawing]

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-readme]: https://github.com/accetto/headless-drawing-g3/blob/master/README.md

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md

[this-issues]: https://github.com/accetto/headless-drawing-g3/issues

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-freecad-g3/

[this-dockerfile]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce.drawing

[this-diagram-dockerfile-stages-drawing]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/Dockerfile.xfce.drawing.png

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
