# airflow-on-EKS

This is an implementation of airflow on AWS EKS with official Helm chart.

Please refer to https://airflow.apache.org/docs/helm-chart/stable/index.html for more details.

AWS EFS is used as dags/logs persistent volume.
You can setup a EFS provisioner with this guide.
https://github.com/kubernetes-incubator/external-storage/tree/master/aws/efs

Customized git-sync sidecar is used to deploy Airflow Dags from remote repo to Airflow server for the following reasons.

1. Not all files under the DAGs repo need to be deployed to Airflow server.
1. If files under dags folder in Airflow server are changed, git-sync may not be able to pull from remote repo.

## K8s deployment

### Requirements
- EFS and storage provisioner
  https://github.com/kubernetes-sigs/aws-efs-csi-driver
- Reloader to refresh changes on config maps
  https://github.com/stakater/Reloader
- Flux with helm operator (v1)
  https://fluxcd.io/legacy/helm-operator/
- kubernetes external secret and AWS secret manager
  https://github.com/external-secrets/kubernetes-external-secrets

### Deploy
```shell
kubectl apply -f k8s_config/
```

## Local Deployment

1. Copy `.local.env` to `.env` and update the values in it.
1. Run for the first time.
    ```shell
    docker volume create --name=airflow_db
    ```
1. Run
    ```shell
    docker compose up -d
    ```
1. Wait for webserver and scheduler to be ready (1st time may take longer and may require restart)
1. Go to http://localhost:8080

    username: `airflow`

    password: `airflow`
