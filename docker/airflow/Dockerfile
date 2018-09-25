# Derived from: https://github.com/apache/incubator-airflow/blob/master/scripts/ci/kubernetes/docker/Dockerfile

FROM python:3.6-slim

# Airflow
ARG AIRFLOW_VERSION=afe857fc4d16e5a5e3df26f55fdacb5a4eaf4655
ENV AIRFLOW_HOME /usr/local/airflow
ENV SLUGIFY_USES_TEXT_UNIDECODE yes
ENV AIRFLOW_GPL_UNIDECODE yes

RUN set -ex \
    && buildDeps=' \
        python3-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        build-essential \
        libblas-dev \
        liblapack-dev \
        libpq-dev \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        python3-requests \
        default-libmysqlclient-dev \
        curl \
        rsync \
        netcat-openbsd \
        git \
#        libstdc++6 \
    && pip install -U pip setuptools wheel cython\
    && pip install kubernetes cryptography psycopg2 flask_oauthlib scp pyarrow pandas tqdm \
    && pip install git+https://github.com/apache/incubator-airflow.git@$AIRFLOW_VERSION#egg=apache-airflow[crypto,postgres,jdbc,mysql,s3,slack,password,ssh,gcp_api,pymongo,redis] \
    && apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

RUN useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow
WORKDIR ${AIRFLOW_HOME}

RUN mkdir /var/log/airflow
RUN chmod 0777 /var/log/airflow

EXPOSE 8080

USER airflow
