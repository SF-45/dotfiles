#!/bin/bash
killall polybar
cd $(dirname ${0})
nohup ./launch.sh
