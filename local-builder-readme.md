# Utility `builder.sh`

Builder command pattern:

```bash
./builder.sh <blend> <cmd> [build-options]
```

Supported values for `<cmd>`: `pre_build`, `build`, `push`, `post_push` and `all`.

Supported values for `<blend>` can be found in the hook script `env.rc`. The typical values are listed below.

Examples:

```bash
./builder.sh latest build --no-cache

### set the environment variables first, e.g. 'source ./secrets.rc'
./builder.sh latest all
```

## accetto/ubuntu-vnc-xfce-opengl-g3

- [x] latest
- [x] latest-chromium
- [x] latest-firefox

```plain
Local only:

- vnc
- vnc-chromium
- vnc-firefox
```

## ubuntu-vnc-xfce-drawio-g3

- [x] drawio
- [x] drawio-chromium
- [x] drawio-firefox

```plain
Local only:

- drawio-vnc
- drawio-vnc-vgl
- drawio-vnc-novnc-vgl
- drawio-vnc-chromium
- drawio-vnc-vgl-chromium
- drawio-vnc-firefox
- drawio-vnc-vgl-firefox
```

## ubuntu-vnc-xfce-inkscape-g3

- [x] inkscape
- [x] inkscape-chromium
- [x] inkscape-firefox

```plain
Local only:

- inkscape-vnc
- inkscape-vnc-vgl
- inkscape-vnc-chromium
- inkscape-vnc-vgl-chromium
- inkscape-vnc-firefox
- inkscape-vnc-vgl-firefox
```

## ubuntu-vnc-xfce-gimp-g3

- [x] gimp
- [x] gimp-chromium
- [x] gimp-firefox

```plain
Local only:

- gimp-vnc
- gimp-vnc-chromium
- gimp-vnc-firefox
```

## ubuntu-vnc-xfce-blender-g3

- [x] blender
- [x] blender-chromium
- [x] blender-firefox

```plain
Local only:

- blender-vnc
- blender-vnc-chromium
- blender-vnc-firefox
```

## ubuntu-vnc-xfce-freecad-g3

- [x] freecad
- [x] freecad-chromium
- [x] freecad-firefox

```plain
Local only:

- freecad-vnc
- freecad-vnc-chromium
- freecad-vnc-firefox
```
