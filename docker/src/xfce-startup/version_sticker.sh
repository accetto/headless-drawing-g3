#!/bin/bash

### resolve also symlinks
_current_dir="$(dirname "$(readlink -f "$0")")"

blender=$("${_current_dir}/version_of.sh" blender)
chromium=$("${_current_dir}/version_of.sh" chromium)
drawio=$("${_current_dir}/version_of.sh" drawio)
firefox=$("${_current_dir}/version_of.sh" firefox)
freecad=$("${_current_dir}/version_of.sh" freecad)
gimp=$("${_current_dir}/version_of.sh" gimp)
inkscape=$("${_current_dir}/version_of.sh" inkscape)
ubuntu=$("${_current_dir}/version_of.sh" ubuntu)

main() {
    local key

    if [[ $# -gt 0 ]] ; then

        while [[ $# -gt 0 ]] ; do

            key="$1"

            if [[ "${key}" = '--' ]] ; then
            
                shift
            fi

            case "${key}" in

                -h )
                    echo "Usage: version_sticker [-h] [-v] [-V] [-f]"
                    echo "-h    help"
                    echo "-v    short version sticker"
                    echo "-V    verbose version sticker"
                    echo "-f    features"
                    ;;

                -f )
                    env | grep "FEATURES_" | sort
                    ;;

                -v )
                    if [[ -n "${blender}" ]] ; then echo "Blender ${blender}" ; fi
                    if [[ -n "${chromium}" ]] ; then echo "Chromium ${chromium}" ; fi
                    if [[ -n "${drawio}" ]] ; then echo "draw.io Desktop ${drawio}" ; fi
                    if [[ -n "${firefox}" ]] ; then echo "Firefox ${firefox}" ; fi
                    if [[ -n "${freecad}" ]] ; then echo "FreeCAD ${freecad}" ; fi
                    if [[ -n "${gimp}" ]] ; then echo "Gimp ${gimp}" ; fi
                    if [[ -n "${inkscape}" ]] ; then echo "Inkscape ${inkscape}" ; fi
                    echo "Ubuntu ${ubuntu}"
                    ;;

                -V )
                    if [[ -n "${blender}" ]] ; then echo "Blender ${blender}" ; fi

                    if [[ -n "${chromium}" ]] ; then echo "Chromium ${chromium}" ; fi

                    version=$("${_current_dir}/version_of.sh" curl)
                    if [[ -n "${version}" ]] ; then echo "curl ${version}" ; fi

                    # version=$("${_current_dir}/version_of.sh" dconf-editor)
                    # if [[ -n "${version}" ]] ; then echo "dconf-editor ${version}" ; fi

                    if [[ -n "${drawio}" ]] ; then echo "draw.io Desktop ${drawio}" ; fi

                    version=$("${_current_dir}/version_of.sh" fakeroot)
                    if [[ -n "${version}" ]] ; then echo "fakeroot ${version}" ; fi

                    if [[ -n "${firefox}" ]] ; then echo "Firefox ${firefox}" ; fi

                    if [[ -n "${freecad}" ]] ; then echo "FreeCAD ${freecad}" ; fi

                    # version=$("${_current_dir}/version_of.sh" gdebi)
                    # if [[ -n "${version}" ]] ; then echo "gdebi ${version}" ; fi

                    if [[ -n "${gimp}" ]] ; then echo "Gimp ${gimp}" ; fi

                    version=$("${_current_dir}/version_of.sh" git)
                    if [[ -n "${version}" ]] ; then echo "git ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" gpg)
                    if [[ -n "${version}" ]] ; then echo "gpg ${version}" ; fi

                    if [[ -n "${inkscape}" ]] ; then echo "Inkscape ${inkscape}" ; fi

                    version=$("${_current_dir}/version_of.sh" jq)
                    if [[ -n "${version}" ]] ; then echo "jq ${version}" ; fi
                    
                    version=$("${_current_dir}/version_of.sh" mousepad)
                    if [[ -n "${version}" ]] ; then echo "Mousepad ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" nano)
                    if [[ -n "${version}" ]] ; then echo "nano ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" novnc)
                    if [[ -n "${version}" ]] ; then echo "noVNC ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" python3)
                    if [[ -n "${version}" ]] ; then echo "Python ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" ristretto)
                    if [[ -n "${version}" ]] ; then echo "Ristretto ${version}" ; fi

                    # version=$("${_current_dir}/version_of.sh" rpm)
                    # if [[ -n "${version}" ]] ; then echo "rpm ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" screenshooter)
                    if [[ -n "${version}" ]] ; then echo "Screenshooter ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" tigervnc)
                    if [[ -n "${version}" ]] ; then echo "TigerVNC ${version}" ; fi

                    echo "Ubuntu ${ubuntu}"

                    version=$("${_current_dir}/version_of.sh" virtualgl)
                    if [[ -n "${version}" ]] ; then echo "VirtualGL ${version}" ; fi

                    # if [[ -n "${vscode}" ]] ; then echo "VSCode ${vscode}" ; fi

                    version=$("${_current_dir}/version_of.sh" websockify)
                    if [[ -n "${version}" ]] ; then echo "websockify ${version}" ; fi
                    ;;
            esac
            shift
        done
    else
        sticker="ubuntu${ubuntu}"

        if [[ -n "${blender}" ]] ; then

            blender="${blender// /}"
            blender="${blender/(/}"
            blender="${blender/)/}"
            sticker="${sticker}"-"blender${blender}"

        elif [[ -n "${drawio}" ]] ; then

            sticker="${sticker}"-"drawio${drawio}"

        elif [[ -n "${freecad}" ]] ; then

            sticker="${sticker}"-"freecad${freecad}"

        elif [[ -n "${gimp}" ]] ; then

            sticker="${sticker}"-"gimp${gimp}"

        elif [[ -n "${inkscape}" ]] ; then

            sticker="${sticker}"-"inkscape${inkscape}"
        fi

        if [[ -n "${chromium}" ]] ; then

            sticker="${sticker}-chromium${chromium}"

        elif [[ -n "${firefox}" ]] ; then

            sticker="${sticker}-firefox${firefox}"
        fi
        
        echo "${sticker}"
    fi
}

main $@
