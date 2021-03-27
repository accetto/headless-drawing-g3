# CHANGELOG

## Project `accetto/headless-drawing-g3`

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

***

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

[accetto-ubuntu-vnc-xfce-drawio-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-drawio-g3
[accetto-ubuntu-vnc-xfce-gimp-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-gimp-g3
[accetto-ubuntu-vnc-xfce-inkscape-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-inkscape-g3
