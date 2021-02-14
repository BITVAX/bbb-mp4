#!/bin/bash

meeting_id=$1

set -a
source <(cat .env | \
    sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +a

echo "Converting $meeting_id to Webm" | systemd-cat -p warning -t bbb-mp4
node bbb-mp4.js "https://$bbb_fqdn/playback/presentation/2.0/playback.html?meetingId=$meeting_id"

echo "Converting $meeting_id to MP4" | systemd-cat -p warning -t bbb-mp4
ffmpeg -nostdin -i ./webm/"$meeting_id".webm -c:v copy video/"$meeting_id".mp4

echo "Moving $meeting_id to be played in browser" | systemd-cat -p warning -t bbb-mp4
mv ./video/"$meeting_id".mp4 /var/www/bigbluebutton-default/recording/
