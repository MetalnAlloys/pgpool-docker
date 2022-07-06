FROM debian:bullseye-slim

RUN apt-get update && apt-get -y install gnupg2 wget lsb-release && \
    apt-get clean all

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

RUN apt-get update && \
    apt-get -y install postgresql-12 postgresql-client-12 && \
    apt-get -y install pgpool2 && \
    apt-get clean all

RUN mkdir -p /var/run/pgpool

EXPOSE 9999 9898

CMD ["/usr/sbin/pgpool", "-n"]
