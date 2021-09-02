# Airflow DAGs deployment

This is a git sync sidecar that sync Airflow DAGs from remote repo to Airflow server.

`rsync` is used to decouple local git repo and the folder mounted on the airflow server for the following reasons.

1. Not all files under the DAGs repo need to be deployed to Airflow server.
1. If files under dags folder in Airflow server are changed, git-sync may not be able to pull from remote repo.

## Flow

1. git-sync pull on a regular interval.
1. `post-sync` is executed after syncing a new hash of the remote repository. It will then sync files under `DAGS_PATH` to `CP_TO_DIR`.
1. If env `SLACK_NOTIFICATION` is set to `true`, a slack notification will be sent.

## Parameters
`git-sync` related parameters can be found in https://github.com/kubernetes/git-sync#parameters

| Environment Variable | Description |
| -------------------- | ----------- |
| DAGS_PATH | The path of the dags in the repo |
| CP_TO_DIR | `rsync` will sync files under `DAGS_PATH` to `CP_TO_DIR` |
| GIT_COMMIT_URL | For Slack message |
| SLACK_NOTIFICATION | `true` if a notification needs to be sent |
| SLACK_TOKEN | Slack bot token |
| SLACK_CHANNEL | Slack channel that the message is sent to |
| SLACK_USERNAME | User name for the slack message |
| SLACK_ICON | Icon for the slack message |
| SLACK_MESSAGE | The text of the message |

## Slack integration

If `SLACK_NOTIFICATION` set to `true`, a notification will be sent after `rsync` run.

Required scopes:
- chat:write
- chat:write.customize
- chat:write.public

## Build

```shell
docker compose build
```

## Local deployment

```shell
export SLACK_TOKEN=xxxx
export SLACK_CHANNEL=Cxxxxx
docker compose up --build -d
```
