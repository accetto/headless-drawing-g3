# Headless Ubuntu/Xfce container with VNC/noVNC and `Inkscape`

## accetto/ubuntu-vnc-xfce-inkscape-g3

[User Guide][this-user-guide] - [GitHub][this-github] - [Dockerfile][this-dockerfile] - [Readme][this-readme-full] - [Changelog][this-changelog]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]

***

This Docker Hub repository contains Docker images for headless working with the free open-source vector drawing application [Inkscape][inkscape].

The images are based on [Ubuntu 24.04 LTS (Noble Numbat)][docker-ubuntu] and include [Xfce][xfce] desktop, [TigerVNC][tigervnc] server and [noVNC][novnc] client.
The popular web browsers [Chromium][chromium] and [Firefox][firefox] are also included.

This [User guide][this-user-guide] describes the images and how to use them.

The related [GitHub project][this-github] contains image generators that image users generally don’t need, unless they want to build the images themselves.

### Tags

The following image tags are regularly built and published on Docker Hub:

<!-- markdownlint-disable MD052 -->

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `chromium` adds Chromium Browser

    ![badge_chromium_created][badge_chromium_created]
    [![badge_chromium_version-sticker][badge_chromium_version-sticker]][link_chromium_version-sticker-verbose]

- `firefox` adds Firefox

    ![badge_firefox_created][badge_firefox_created]
    [![badge_firefox_version-sticker][badge_firefox_version-sticker]][link_firefox_version-sticker-verbose]

<!-- markdownlint-enable MD052 -->

**Hint:** Clicking the version sticker badge reveals more information about the particular build.

### Features

The main features and components of the images in the default configuration are:

- lightweight [Xfce][xfce] desktop environment (Debian distribution)
- [sudo][sudo] support
- current version of JSON processor [jq][jq]
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Ubuntu distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Ubuntu distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding environment variables, VNC parameters, user and group (see [User guide][this-user-guide-using-containers])
- support of **version sticker** (see [User guide][this-user-guide-version-sticker])
- current version of [Chromium Browser][chromium] open-source web browser (from the `Ubuntu 18.04 LTS` distribution)
- current non-snap [Firefox][firefox] version from the Mozilla Team PPA and also the additional **Firefox plus** feature (see [User guide][this-user-guide-firefox-plus])
- free open-source vector drawing application [Inkscape][inkscape]  (Ubuntu distribution)

The following **TCP** ports are exposed by default:

- **5901** for access over **VNC** (using VNC viewer)
- **6901** for access over [noVNC][novnc] (using web browser)

![container-screenshot][this-screenshot-container]

### Remarks

The images contain the current Chromium Browser from the `Ubuntu 18.04 LTS` distribution.
This is because the versions for `Ubuntu 24.04 LTS` depend on `snap`, which is currently not supported in Docker containers.

The [Chromium Browser][chromium] in these images runs in the `--no-sandbox` mode.
You should be aware of the implications.

The [Firefox][firefox] browser included in the images is the current non-snap version from the Mozilla Team PPA.
It's because the `Ubuntu 24.04 LTS` distribution contains only the `snap` version and the `snap` is currently not supported in Docker containers.

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

### Getting help

If you've found a problem or you just have a question, please check the [User guide][this-user-guide], [Issues][this-issues] and [sibling Wiki][sibling-wiki] first.
Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue.
The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can also use the [sibling Discussions][sibling-discussions].

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-user-guide-version-sticker]: https://accetto.github.io/user-guide-g3/version-sticker/

[this-user-guide-using-containers]: https://accetto.github.io/user-guide-g3/using-containers/

[this-user-guide-firefox-plus]: https://accetto.github.io/user-guide-g3/firefox-plus/

[this-changelog]: https://github.com/accetto/headless-drawing-g3/blob/master/CHANGELOG.md

[this-github]: https://github.com/accetto/headless-drawing-g3/

[this-issues]: https://github.com/accetto/headless-drawing-g3/issues

[this-readme-full]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/xfce-inkscape/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-dockerfile]: https://github.com/accetto/headless-drawing-g3/blob/master/docker/Dockerfile.xfce.drawing

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-drawing-g3/master/docker/doc/images/animation-headless-drawing-inkscape-live.gif

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[inkscape]: https://inkscape.org/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[sudo]: https://www.sudo.ws/
[tigervnc]: http://tigervnc.org
[tini]: https://github.com/krallin/tini
[xfce]: http://www.xfce.org

[badge-github-release]: https://badgen.net/github/release/accetto/headless-drawing-g3?icon=github&label=release

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-inkscape-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-inkscape-g3?icon=docker&label=stars

<!-- Appendix will be added by util-readme.sh -->
