FROM postgres:10.3-alpine

ENV PGDATA /var/lib/pgsql/data/

COPY init.sql/* /init.sql/

RUN set -ex \
        && apk add --no-cache curl \
        \
        && sh -c '/docker-entrypoint.sh postgres --autovacuum=off --max_wal_size=3GB &' \
        && sleep 5 \
        && for f in /init.sql/*; do psql -U postgres -nx -v ON_ERROR_STOP=1 -f $f; rm -f $f; done \
        && su -s /bin/bash -c "pg_ctl -D "$PGDATA" -m fast -w stop" postgres \
        && sleep 5 \
        && su -s /bin/bash -c "pg_resetwal -o $( LANG=C pg_controldata $PGDATA | grep 'NextOID:' | sed -r 's/(.*)NextOID:(\s+)//' ) -x $( LANG=C pg_controldata $PGDATA | grep 'NextXID:' | sed -r 's/(.*)NextXID:(\s+)0[/:]//' ) -f $PGDATA" postgres \
        \
        && apk del curl \
        && rm -rf /var/cache/apk/*
