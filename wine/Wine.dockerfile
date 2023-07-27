FROM scottyhardy/docker-wine:latest

SHELL ["/bin/bash", "-c"]

ENV LC_ALL="ru_RU.CP1251"
ENV LC_CTYPE="ru_RU.CP1251"
ENV LANG="ru_RU.CP1251"

RUN apt update

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt install --yes locales && \
    apt install --yes ttf-mscorefonts-installer && \
    apt install --yes winetricks && \
    locale-gen "ru_RU.CP1251" && \
    locale-gen "en_US.UTF-8" && \
    winetricks corefonts

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/bin/entrypoint"]
