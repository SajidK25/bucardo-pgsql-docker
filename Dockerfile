FROM ubuntu:focal

ARG PG_VERSION="12"
ARG BUCARDO_VERSION="5.6.0"

RUN apt-get -y update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends postgresql-${PG_VERSION} wget \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends postgresql-plperl make \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends libdbix-safe-perl libencode-locale-perl \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends libcgi-pm-perl libdbd-pg-perl \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget --no-check-certificate http://bucardo.org/downloads/Bucardo-${BUCARDO_VERSION}.tar.gz \
    && tar xzvf Bucardo-${BUCARDO_VERSION}.tar.gz \
    && cd Bucardo-${BUCARDO_VERSION} \
    && perl Makefile.PL \
    && make \
    && make install \
    && cd /tmp \
    && rm -rf Bucardo-${BUCARDO_VERSION}*

ADD configs/pg_hba.conf /etc/postgresql/${PG_VERSION}/main/pg_hba.conf
ADD configs/bucardorc /etc/bucardorc
ADD /startup.sh /startup.sh

RUN chown postgres /etc/postgresql/${PG_VERSION}/main/pg_hba.conf
RUN chown postgres /etc/bucardorc
RUN chmod +x /startup.sh
RUN mkdir -p /var/log/bucardo && chown postgres /var/log/bucardo
RUN mkdir -p /var/run/bucardo && chown postgres /var/run/bucardo

RUN service postgresql start \
    && su - postgres -c "bucardo install --batch"

ENTRYPOINT ["/bin/bash", "-c", "/startup.sh"]