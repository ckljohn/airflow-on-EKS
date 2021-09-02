ARG git_sync_version

FROM k8s.gcr.io/git-sync/git-sync:$git_sync_version
USER 0

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         rsync curl\
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ARG export_dir
RUN mkdir $export_dir && chgrp 65533 $export_dir && chmod 775 $export_dir

USER 65533

COPY post-sync.sh /usr/bin/post-sync
COPY send-slack-notification.sh /usr/bin/send-slack-notification
