#!/bin/sh
set -eu

COMMIT_HASH=$(git log -1 --pretty="%h")
COMMIT_AUTHOR=$(git log -1 --pretty="%an")
COMMIT_SUBJECT=$(git log -1 --pretty="%s")

curl --location --request POST 'https://slack.com/api/chat.postMessage' \
    --header "Authorization: Bearer $SLACK_TOKEN" \
    --header 'Content-Type: application/json' \
    --data '{
        "channel": "'"$SLACK_CHANNEL"'",
        "username": "'"$SLACK_USERNAME"'",
        "icon_emoji": "'"$SLACK_ICON"'",
        "text": "'"$SLACK_MESSAGE"'",
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "plain_text",
                    "text": "'"$SLACK_MESSAGE"'",
                    "emoji": true
                }
            },
            {
                "type": "section",
                "fields": [
                    {"type": "mrkdwn", "text": "*Hash*\n'"<$GIT_COMMIT_URL|$COMMIT_HASH>"'"},
                    {"type": "mrkdwn", "text": "*Author*\n'"$COMMIT_AUTHOR"'"}
                ]
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*Subject*\n'"$COMMIT_SUBJECT"'"
                }
            }
        ]
    }'
