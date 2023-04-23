#!/bin/bash

app_image=$(ls "${FREECAD_PATH}"/FreeCAD_*.AppImage 2>/dev/null)
startup_log="${HOME}/freecad_launcher.log"

if [[ -z "${app_image}" ]] ; then

    echo "No FreeCAD found!"
    echo "Exiting..."
    sleep 5
    exit
fi

echo "FreeCAD starting... please wait"
echo "...extracting AppImage"
echo "...launcher log: ${startup_log}"

"${app_image}" --appimage-extract-and-run 2>"${startup_log}"

echo "Cleaning-up... please wait"

sleep 3

rm -rf /tmp/FreeCADStart*
