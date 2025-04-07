# Utility `ci-builder.sh`

- [Utility `ci-builder.sh`](#utility-ci-buildersh)
  - [Introduction](#introduction)
  - [Preparation](#preparation)
    - [Ensure file attributes after cloning](#ensure-file-attributes-after-cloning)
    - [Set environment variables before building](#set-environment-variables-before-building)
    - [Ensure `wget` utility](#ensure-wget-utility)
  - [Usage modes](#usage-modes)
    - [Group mode](#group-mode)
      - [Group mode examples](#group-mode-examples)
    - [Family mode](#family-mode)
      - [Family mode examples](#family-mode-examples)
    - [Log processing](#log-processing)
      - [Digest command](#digest-command)
      - [Stickers command](#stickers-command)
      - [Timing command](#timing-command)
      - [Errors command](#errors-command)
  - [Additional building parameters](#additional-building-parameters)

## Introduction

This utility script can build and publish sets of images.
It can also extract selected information from the building log.

The common usage pattern

```shell
./ci-builder.sh <mode> <argument> [<optional-argument>]...
```

has the following typical forms that also described below:

```shell
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)
```

The supported option values can be taken from the embedded help:

```shell
This script can:
    - build sets of images using the builder script 'builder.sh'
    - extract selected information from the log

Usage: <script> <mode> <argument> [<optional-argument>]...

    ./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
    ./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
    ./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)

<options>      := (--log-all|--no-cache) 
<command>      := (all|all-no-push)
<mode>         := (family|group)
<parent-blend> := (complete)|(latest|blender|drawio|gimp|inkscape)
<child-suffix> := (-chromium|-firefox)
<blend>        := (pivotal)
                  |(complete[-chromium|-firefox|-latest|-blender|-drawio|-gimp|-inkscape])
                  |(latest|blender|drawio|gimp|inkscape)[-(chromium|firefox)])

Family mode: The children are skipped if a new parent image was not actually built.
Group mode : All images are processed independently.

The command and the blend are passed to the builder script.
The result "<parent-blend><child-suffix>" must be a blend supported by the builder script.

The script creates a complete execution log.
```

The optional parameter `--no-cache` will be passed to the internally used script `builder.sh`.

The optional parameter `--log-all` will cause that the script's output will be written into the log file in all cases.
Normally the command line errors or the **log processing mode** commands are not logged.

## Preparation

### Ensure file attributes after cloning

It may be necessary to repair the executable files attributes after cloning the repository (by `git clone`).

You can do that by executing the following commands from the project's root directory:

```shell
find . -type f -name "*.sh" -exec chmod +x '{}' \;
chmod +x docker/hooks/*
```

For example, if the files in the folder `docker/hooks` would not be executable, then you would get errors similar to this:

```shell
$ ./builder.sh latest build

==> EXECUTING @2023-03-05_16-42-57: ./builder.sh 

./builder.sh: line 84: ./docker/hooks/build: Permission denied
```

### Set environment variables before building

Open a terminal windows and change the current directory to the root of the project (where the license file is).

Make a copy of the secrets example file, modify it and then source it in the terminal:

```shell
### make a copy and then modify it
cp examples/example-secrets.rc secrets.rc

### source the secrets
source ./secrets.rc

### or also

. ./secrets.rc
```

**TIP**: If you copy a file named `secrets.rc` into the folder `docker/hooks/`, then it will be automatically sourced by the hook script `env.rc`.

Be aware that the following environment variables are mandatory and must be always set:

- `REPO_OWNER_NAME`
- `BUILDER_REPO`

Ensure that your `secrets.rc` file contains at least the lines similar to these:

```shell
export REPO_OWNER_NAME="accetto"
export BUILDER_REPO="headless-drawing-g3"
```

You can use your own names if you wish.

Alternatively you can modify the hook script file env.rc like this:

```shell
### original lines
declare _owner="${REPO_OWNER_NAME:?Need repo owner name}"
DOCKER_REPO="${_owner}/${BUILDER_REPO:?Need builder repo name}"

### modified lines
declare _owner="${REPO_OWNER_NAME:-accetto}"
DOCKER_REPO="${_owner}/${BUILDER_REPO:-headless-drawing-g3}"
```

Again, you can use your own names if you wish.

You can also use other ways to set the variables.

### Ensure `wget` utility

If you are on Windows, you can encounter the problem of missing `wget` utility.
It is used by refreshing the `g3-cache` and it's available on Linux by default.

On Windows you have generally two choices.
You can build your images inside the `WSL` environment or you can download the `wget.exe` application for Windows.
Make sure to update also the `PATH` environment variable appropriately.

Since the version `25.04` the availability of the utility is checked.

The checking can be skipped by setting the environment variable `IGNORE_MISSING_WGET=1`.

The selected packages still will be downloaded into a temporary image layer, but not into the project's
`.g3-cache` folder nor the shared one, defined by the variable `SHARED_G3_CACHE_PATH`.

## Usage modes

### Group mode

The **group mode** is intended for building sets of independent images.

The **group mode** usage pattern:

```shell
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
```

#### Group mode examples

The image tags can be listed in the command line.
For example, all these images will be built independently of each other.

```shell
./ci-builder.sh all group blender drawio-firefox gimp inkscape
```

You can also use one of the **named groups**:

```shell
### includes the images 'latest', 'drawio', 'gimp' and 'inkscape'
### excluding 'blender' and 'freecad' (because of their image sizes)
./ci-builder.sh all group pivotal

### includes almost all the images
### excluding 'blender' and 'freecad' (because of their image sizes)
./ci-builder.sh all group complete

### includes almost all the images featuring the Firefox browser
### excluding 'blender' and 'freecad' (because of their image sizes)
./ci-builder.sh all group complete-firefox

### includes almost all the images featuring the Chromium Browser
### excluding 'blender' and 'freecad' (because of their image sizes)
./ci-builder.sh all group complete-chromium

### includes all the images featuring the named application
### 'latest' stands for 'opengl' in this context
./ci-builder.sh all group complete-latest
./ci-builder.sh all group complete-blender
./ci-builder.sh all group complete-drawio
./ci-builder.sh all group complete-gimp
./ci-builder.sh all group complete-inkscape
./ci-builder.sh all group complete-freecad
```

### Family mode

The **family mode** is intended for an efficient building of the sets of dependent images.

**Remark:** Since the version G3v3 of the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] is this mode for advanced use only.
The previous images `accetto/ubuntu-vnc-xfce-g3:latest-fugo` and `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` that used it are not published any more.
The image `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` has been renamed to `accetto/ubuntu-vnc-xfce-firefox-g3:latest`.

The dependency in this context is meant more technically than conceptually.

The following example will help to understand the concept.

This project currently does not include any images that are in such a relation.
Therefore it will be explained using the images from the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].

The image `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` added some additional features to the image `accetto/ubuntu-vnc-xfce-firefox-g3:latest`, but otherwise were both images identical.

In such case a conclusion can be made, that if the `latest` tag does not need a refresh, then also the `latest-plus` tag doesn't need it and its building can be skipped.

There had been a similar dependency between the images `accetto/ubuntu-vnc-xfce-g3:latest` and `accetto/ubuntu-vnc-xfce-g3:latest-fugo`.

This kind of family-like relation allows to refresh the images more efficiently by skipping the "children" if the "parent" doesn't need a re-build.

The **family mode** usage pattern:

```shell
./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
```

Note that the children tags are specified by their suffixes to the parent's tag.

#### Family mode examples

The following cases bring the efficiency advantage:

```shell
### image 'latest-fugo' will be skipped if the 'latest' image doesn't need a re-build
./ci-builder.sh all family latest -fugo

### 'firefox' image 'latest-plus' will be skipped if the 'latest' image doesn't need a re-build 
./ci-builder.sh all family latest-firefox -plus
```

The following command can also be used, but there would be no benefit comparing to the equivalent **group mode** command:

```shell
./ci-builder.sh all family latest-chromium
```

You can also skip the publishing to the **Docker Hub** by replacing the `all` command by the `all-no-push` one.
For example:

```shell
### image 'latest-fugo' will be skipped if the 'latest' image doesn't need a re-build
./ci-builder.sh all-no-push family latest -fugo
```

### Log processing

The **log processing** mode is intended for evaluating the outcome of the latest image building session.
The result are extracted from the **ci-builder log** by `grep` utility.

The **log processing mode** usage pattern:

```shell
./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)
```

#### Digest command

The `digest` command extracts the information about the images that have been re-built or that do not require that.

```shell
./ci-builder.sh log get digest
```

The output can look out like this:

```text
--> Log digest:

Building image 'headless-drawing-g3:gimp'
Building image 'headless-drawing-g3:gimp-chromium'
Building image 'headless-drawing-g3:gimp-firefox' 
Built new 'headless-drawing-g3:gimp'.
Built new 'headless-drawing-g3:gimp-chromium'.
Built new 'headless-drawing-g3:gimp-firefox'.
```

#### Stickers command

The `stickers` command extracts the information about the **version stickers** of the ephemeral helper images that have been built by the `pre_build` hook script.
That does not mean that the final persistent images have also been built (and optionally also published).

```shell
./ci-builder.sh log get stickers
```

The output can look out like this:

```text
--> Version stickers:

Current version sticker of 'accetto/headless-drawing-g3:gimp_helper': ubuntu22.04.2-gimp2.10.30
Current version sticker of 'accetto/headless-drawing-g3:gimp-chromium_helper': ubuntu22.04.2-gimp2.10.30-chromium110.0.5481.100
Current version sticker of 'accetto/headless-drawing-g3:gimp-firefox_helper': ubuntu22.04.2-gimp2.10.30-firefox111.0
```

#### Timing command

The `timing` command extracts the selected timestamps that give an approximation of the building duration.

```shell
./ci-builder.sh log get timing
```

The output can look out like this:

```text
--> Building timing:

==> EXECUTING @2023-03-11_17-04-05: ./ci-builder.sh
==> EXECUTING @2023-03-11_17-04-05: ./builder.sh
==> FINISHED  @2023-03-11_17-04-43: ./builder.sh
==> EXECUTING @2023-03-11_17-04-43: ./builder.sh
==> FINISHED  @2023-03-11_17-05-22: ./builder.sh
==> EXECUTING @2023-03-11_17-05-22: ./builder.sh
==> FINISHED  @2023-03-11_17-06-43: ./builder.sh
==> FINISHED  @2023-03-11_17-06-43: ./ci-builder.sh
```

#### Errors command

The errors command extract the information about the possible errors during the building.

```shell
./ci-builder.sh log get errors
```

The output is mostly empty:

```text
--> Building errors:

```

## Additional building parameters

There is no notion of additional building parameters by the script `ci-builder.sh` (compare to [builder.sh][readme-builder]).

There is no way to build the images only from particular Dockerfile stages using the script `ci-builder.sh`.

***

[readme-builder]: https://github.com/accetto/headless-drawing-g3/blob/master/readme-builder.md

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3
