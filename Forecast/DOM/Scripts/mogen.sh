#!/bin/sh
#  mogen.sh
#

HUMAN_DIR="${PROJECT_DIR}/Forecast/DOM”
MACHINE_DIR="${PROJECT_DIR}/Forecast/DOM/Machine"
INCLUDE_H="${PROJECT_DIR}/Forecast/DOM/ModelIncludes.h"

mogenerator = mogenerator

echo $mogenerator --model \"${INPUT_FILE_PATH}\" --machine-dir "$MACHINE_DIR/" --human-dir "$HUMAN_DIR/" --includeh "$INCLUDE_H" --template-var arc=true
$mogenerator --model \"${INPUT_FILE_PATH}\" --machine-dir "$MACHINE_DIR/" --human-dir "$HUMAN_DIR/" --includeh "$INCLUDE_H" --template-var arc=true

echo ${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 \"${INPUT_FILE_PATH}\" \"${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom\"
${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"

echo "that's all folks. mogen.sh is done"