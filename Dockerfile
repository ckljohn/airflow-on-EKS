# https://airflow.apache.org/docs/docker-stack/build.html#examples-of-image-extending

FROM apache/airflow:2.1.2
USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim git\
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER airflow

RUN pip install --no-cache-dir \
    GitPython \
    apache-airflow-providers-http==1.1.1 \
    apache-airflow-providers-amazon==1.0.0 \
    apache-airflow-providers-cncf-kubernetes==1.2.0 \
    apache-airflow-providers-google==3.0.0 \
    apache-airflow-providers-mysql==1.1.0 \
    apache-airflow-providers-postgres==1.0.2 \
    apache-airflow-providers-redis==1.0.1 \
    apache-airflow-providers-mongo==1.0.1 \
    apache-airflow-providers-sftp==1.2.0
