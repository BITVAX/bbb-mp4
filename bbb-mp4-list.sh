#!/bin/bash
cat $1 | xargs -i find /var -name {} | grep published | xargs -i grep "<duration>" {}/metadata.xml | grep -oP '\d+' | awk 'BEGIN{sum=0} { sum += $1; printf "%d:%02d\n", int($1/3600000),($1-(int($1/3600000)*3600000))/60000 } END{ printf "%d:%02d\n", int(sum/3600000),(sum-(int(sum/3600000)*3600000))/60000 }'
cat $1 | xargs -i bash bbb-mp4.sh {}
