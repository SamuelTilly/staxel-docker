#!/bin/bash

if [[ -z "$STEAM_ACCOUNT" ]] && [[ -z "$STEAM_PASSWORD" ]]; then
    if [[ -d "$STEAMAPPDIR/bin" ]]; then
        cd "$STEAMAPPDIR/bin"
        xvfb-run mono "$STEAMAPPDIR/bin/Staxel.Server.exe" \
            --creative="$CREATIVE" \
            --name="$NAME" \
            --password="$PASSWORD" \
            --playerlimit="$PLAYERLIMIT" \
            --port="$PORT" \
            --public="$PUBLIC" \
            --storage="$STORAGE" \
            --upnp="$UPNP" \
            $ADDITIONAL_ARGS
    else
        echo "Unable to find game folder"
        exit 1
    fi
else
    "$HOMEDIR/steamcmd/steamcmd.sh" \
        +@sSteamCmdForcePlatformType windows \
        +login $STEAM_ACCOUNT $STEAM_PASSWORD \
        +force_install_dir "$STEAMAPPDIR" \
        +app_update "$STEAMAPPID" \
        +quit
fi
