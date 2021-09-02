#!/bin/sh
set -eu

rsync -rvuc --links --delete --exclude='__pycache__' "${DAGS_PATH}" "${CP_TO_DIR}"

if [ "${SLACK_NOTIFICATION}" = true ]; then
    send-slack-notification
fi
