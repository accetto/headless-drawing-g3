#!/bin/bash -e

main() {
    local result=""

    case "$1" in

        chromium-1804 )
            # result=$(wget -qO- \
            result=$(curl -sL \
                http://archive.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/ \
                | grep -Po -m1 '(?<=href=")[^_]*_([0-9.]+-0ubuntu0\.18\.04\.[^_"]*)_[^"]*' \
                | cut -d _ -f 2 \
            )
            ;;

        drawio )
            # result=$(wget -qO- \
            result=$(curl -sL -H "Accept: application/vnd.github.v3+json" \
                https://api.github.com/repos/jgraph/drawio-desktop/releases/latest \
                | grep -m1 "tag_name" \
                | grep -Po '[0-9.]+'
            )
            ;;

        virtualgl )
            # result=$(wget -qO- \
            result=$(curl -sL \
                https://sourceforge.net/projects/virtualgl/files/ \
                | grep -Po -m1 '<tr title="[0-9.]+" class="folder\s?">' \
                | grep -Po '[0-9.]+' \
            )
            ;;

        * )
            echo "Unknown key '$1'"
            return 1
            ;;

    esac

    echo "${result}"
}

main $@
