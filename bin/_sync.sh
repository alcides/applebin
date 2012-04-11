#!/bin/bash

rsync -auv $1 $2 --exclude=".pyc"
