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

Builds for Docker Hub:

| Blend           | Deployment tag |
| --------------- | -------------- |
| latest          | latest         |
| latest-chromium | chromium       |
| latest-firefox  | firefox        |

Local builds only:

| Blend        | Deployment tag |
| ------------ | -------------- |
| vnc          | vnc            |
| vnc-chromium | vnc-chromium   |
| vnc-firefox  | vnc-firefox    |

## ubuntu-vnc-xfce-drawio-g3

Builds for Docker Hub:

| Blend           | Deployment tag |
| --------------- | -------------- |
| drawio          | latest         |
| drawio-chromium | chromium       |
| drawio-firefox  | firefox        |

Local builds only:

| Blend                   | Deployment tag   |
| ----------------------- | ---------------- |
| drawio-vnc              | vnc              |
| drawio-vnc-vgl          | vnc-vgl          |
| drawio-vnc-chromium     | vnc-chromium     |
| drawio-vnc-vgl-chromium | vnc-vgl-chromium |
| drawio-vnc-firefox      | vnc-firefox      |
| drawio-vnc-vgl-firefox  | vnc-vgl-firefox  |

## ubuntu-vnc-xfce-inkscape-g3

Builds for Docker Hub:

| Blend             | Deployment tag |
| ----------------- | -------------- |
| inkscape          | latest         |
| inkscape-chromium | chromium       |
| inkscape-firefox  | firefox        |

Local builds only:

| Blend                     | Deployment tag   |
| ------------------------- | ---------------- |
| inkscape-vnc              | vnc              |
| inkscape-vnc-vgl          | vnc-vgl          |
| inkscape-vnc-chromium     | vnc-chromium     |
| inkscape-vnc-vgl-chromium | vnc-vgl-chromium |
| inkscape-vnc-firefox      | vnc-firefox      |
| inkscape-vnc-vgl-firefox  | vnc-vgl-firefox  |

## ubuntu-vnc-xfce-gimp-g3

Builds for Docker Hub:

| Blend         | Deployment tag |
| ------------- | -------------- |
| gimp          | latest         |
| gimp-chromium | chromium       |
| gimp-firefox  | firefox        |

Local builds only:

| Blend             | Deployment tag |
| ----------------- | -------------- |
| gimp-vnc          | vnc            |
| gimp-vnc-chromium | vnc-chromium   |
| gimp-vnc-firefox  | vnc-firefox    |

## ubuntu-vnc-xfce-blender-g3

Builds for Docker Hub:

| Blend            | Deployment tag |
| ---------------- | -------------- |
| blender          | latest         |
| blender-chromium | chromium       |
| blender-firefox  | firefox        |

Local builds only:

| Blend                | Deployment tag |
| -------------------- | -------------- |
| blender-vnc          | vnc            |
| blender-vnc-chromium | vnc-chromium   |
| blender-vnc-firefox  | vnc-firefox    |

## ubuntu-vnc-xfce-freecad-g3

Builds for Docker Hub:

| Blend            | Deployment tag |
| ---------------- | -------------- |
| freecad          | latest         |
| freecad-chromium | chromium       |
| freecad-firefox  | firefox        |

Local builds only:

| Blend                | Deployment tag |
| -------------------- | -------------- |
| freecad-vnc          | vnc            |
| freecad-vnc-chromium | vnc-chromium   |
| freecad-vnc-firefox  | vnc-firefox    |
