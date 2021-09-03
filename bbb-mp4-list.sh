#!/bin/bash
cat $1 | xargs -i bash bbb-mp4.sh {}
