FROM cm2network/steamcmd:root

# Install mono
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        apt-transport-https \
        dirmngr gnupg \
        ca-certificates \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests mono-complete

# Install xvfb
ENV DISPLAY 99
RUN set -x && \
    apt-get install -y --no-install-recommends --no-install-suggests xauth xvfb

# Install fnalibs
ENV FNA_CHECKSUM 735cd7deaa4cfdfb67dbc5fb1ba5d747551d22c92d7aee89a153fb3fa263c67f
RUN set -x && \
    apt-get install -y --no-install-recommends --no-install-suggests bzip2 && \
    curl http://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 --output "$HOMEDIR/fnalibs.tar.bz2" && \
    echo "$FNA_CHECKSUM  $HOMEDIR/fnalibs.tar.bz2" | shasum -c && \
    mkdir -p "$HOMEDIR/fnalibs" && \
    tar -xf "$HOMEDIR/fnalibs.tar.bz2" -C "$HOMEDIR/fnalibs" && \
    mkdir -p /usr/lib/fnalibs && \
    cp "$HOMEDIR"/fnalibs/x64/*.dll /usr/lib/fnalibs && \
    cp "$HOMEDIR"/fnalibs/lib64/*.so* /usr/lib/ && \
    rm -rf "$HOMEDIR/fnalibs" "$HOMEDIR/fnalibs.tar.bz2"

ENV STEAMAPPID 405710
ENV STEAMAPP staxel
ENV STEAMAPPDIR "$HOMEDIR/$STEAMAPP-dedicated"

COPY entry.sh $HOMEDIR/entry.sh
RUN mkdir -p "$STEAMAPPDIR" && \
    chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

ENV CREATIVE="false" \
    NAME="myFarm" \
    PASSWORD="potato" \
    PLAYERLIMIT=8 \
    PORT=38465 \
    PUBLIC="false" \
    STORAGE="myFarm" \
    UPNP="false" \
    ADDITIONAL_ARGS=""

USER $USER

VOLUME $STEAMAPPDIR

WORKDIR $HOMEDIR

CMD ["bash", "entry.sh"]

EXPOSE 38465/tcp
