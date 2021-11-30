#!/bin/bash

# Load .env variables
set -a
source <(cat  $(pwd)/.env | \
    sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +a

MEETING_ID=$1

echo "converting $MEETING_ID to mp4" |  systemd-cat -p warning -t bbb-mp4
docker rm -f $MEETING_ID
rm -f $COPY_TO_LOCATION/$MEETING_ID.mp4

sudo docker run --rm $2 \
                --name bbb-mp4-$MEETING_ID \
                -v $COPY_TO_LOCATION:/usr/src/app/download \
                --env-file  $(pwd)/.env \
                --env REC_URL=https://$BBB_DOMAIN_NAME/playback/presentation/2.3/$MEETING_ID?meetingID=$MEETING_ID \
                bbb-mp4:2.3