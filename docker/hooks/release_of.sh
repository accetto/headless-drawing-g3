#!/bin/bash -e

main() {
    local result=""

    case "$1" in

        chromium-1804)
            result=$( \
                curl -s http://archive.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/ \
                | grep -Po -m1 '(?<=href=")[^_]*_([0-9.]+-0ubuntu0\.18\.04\.[^_"]*)_[^"]*' \
                | cut -d _ -f 2 )
            ;;

        drawio )
            result=$( \
                curl -s -H "Accept: application/vnd.github.v3+json" \
                https://api.github.com/repos/jgraph/drawio-desktop/releases \
                | grep -m1 "tag_name" | grep -Po "[0-9.]+"
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
