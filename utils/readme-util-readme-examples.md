# Examples `util-readme.sh`

## Preparation

Open a terminal window and change the current directory to `utils/`.

The utility requires the `ID` of the deployment **GitHub Gist**, which you can provide as a parameter or by setting the environment variable `DEPLOY_GIST_ID`:

```shell
export DEPLOY_GIST_ID="<deployment-gist-ID>"
```

Embedded help describes the parameters:

```shell
./util-readme.sh -h
```

## Usage examples

```shell
### PWD = utils/

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-opengl-g3 --context=../docker/xfce --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-blender-g3 --context=../docker/xfce-blender --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-drawio-g3 --context=../docker/xfce-drawio --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-freecad-g3 --context=../docker/xfce-freecad --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-gimp-g3 --context=../docker/xfce-gimp --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-inkscape-g3 --context=../docker/xfce-inkscape --gist <deployment-gist-ID> -- preview

### or if the environment variable 'DEPLOY_GIST_ID' has been set

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-opengl-g3 --context=../docker/xfce -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-blender-g3 --context=../docker/xfce-blender -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-drawio-g3 --context=../docker/xfce-drawio -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-freecad-g3 --context=../docker/xfce-freecad -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-gimp-g3 --context=../docker/xfce-gimp -- preview

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-inkscape-g3 --context=../docker/xfce-inkscape -- preview
```

See the sibling Wiki page ["Utility util-readme.sh"][sibling-wiki-utility-util-readme] for more information.

***

[sibling-wiki-utility-util-readme]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/Utility-util-readme
