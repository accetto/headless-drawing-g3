# Examples `util-readme.sh`

## Preparation

You have to have `curl` installed for this utility.

Open a terminal window and change the current directory to `utils`.

Then copy the secrets example file, modify the copy and source it:

```bash
### make a copy and then modify it
cp example-secrets-utils.rc secrets-utils.rc

### source the secrets
source ./secrets-utils.rc
```

Optionally you can provide the secrets as command line parameters.

You can also provide the secrets file as a command line parameter instead of sourcing it.

Embedded help describes the parameters:

```bash
./util-readme.sh -h
```

## Usage examples

```bash
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-blender-g3 --context=../docker/xfce-blender -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-blender-g3 --context=../docker/xfce-blender -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-drawio-g3 --context=../docker/xfce-drawio -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-drawio-g3 --context=../docker/xfce-drawio -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-freecad-g3 --context=../docker/xfce-freecad -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-freecad-g3 --context=../docker/xfce-freecad -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-gimp-g3 --context=../docker/xfce-gimp -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-gimp-g3 --context=../docker/xfce-gimp -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-inkscape-g3 --context=../docker/xfce-inkscape -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-inkscape-g3 --context=../docker/xfce-inkscape -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-opengl-g3 --context=../docker/xfce -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-opengl-g3 --context=../docker/xfce -- publish
```
