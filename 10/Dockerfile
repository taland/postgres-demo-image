FROM postgres:10.3

ENV PGDATA /var/lib/pgsql/data/

COPY init.sql/* /init.sql/

RUN set -ex \
        && apt-get update \
        && apt-get install -y curl \
        \
        && bash -c '/docker-entrypoint.sh postgres --autovacuum=off --max_wal_size=3GB &' \
        && sleep 5 \
        && for f in /init.sql/*; do psql -U postgres -nxq -v ON_ERROR_STOP=1 -f $f; rm -f $f; done \
        && gosu postgres pg_ctl -D "$PGDATA" -m fast -w stop \
        && sleep 5 \
        && gosu postgres pg_resetwal -o $( LANG=C pg_controldata $PGDATA | grep -oP '(?<=NextOID:\s{10})\d+' ) -x $( LANG=C pg_controldata $PGDATA | grep -oP '(?<=NextXID:\s{10}0[/:])\d+' ) -f $PGDATA \
        && apt-get autoremove -y curl \
        && rm -rf /var/lib/apt/lists/*
