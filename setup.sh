#!/usr/bin/env bash
kubectl create ns airflow

pushd helm
helm upgrade --install --force  airflow .
popd

# helm delete --purge airflow
