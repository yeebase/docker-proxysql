FROM quay.io/yeebase/debian-base:jessie

ENV PROXYSQL_VERSION 1.4.9

RUN set -x && \
    clean-install ca-certificates curl libssl1.0.0 && \
    curl -fsSL https://github.com/sysown/proxysql/releases/download/v${PROXYSQL_VERSION}/proxysql_${PROXYSQL_VERSION}-dbg-debian9_amd64.deb -o /tmp/proxysql.deb && \
    dpkg -i /tmp/proxysql.deb && \
    rm -rf /tmp/*

COPY proxysql.cnf /etc/

VOLUME ["/var/lib/proxysql"]

EXPOSE 3306 6032

CMD ["proxysql", "-f", "--initial", "-c", "/etc/proxysql.cnf"]
