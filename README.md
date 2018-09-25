# airflow-on-EKS

This is a deployment of airflow onAWS EKS.

I am using AWS EFS as the shared volume. You can use NFS if your want.
You can setup a EFS provisioner with this guide.  
https://github.com/kubernetes-incubator/external-storage/tree/master/aws/efs

I am using ingress with traefik for simplicity. nginx for sure is more powerful.

## DAG deployment

I have another docker image that store all my dags and plugins. When combine with CI and Keel, 
dags can be auto deployed to airflow after a git commit.

## Setup

1. Copy the folder `secrets.smaple` to `secrets` and fill in the secret.

1. Copy `values.sample.yaml` to `values.yaml` and fill in the values.

1. Copy  `helm/files/airflow.sample.cfg` to `helm/files/airflow.cfg` and modify 
according to your environment. 

1. Run `setup.sh`
