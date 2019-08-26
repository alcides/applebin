#!/bin/bash

sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`

sudo kextunload /System/Library/Extensions/AppleHDA.kext 
sudo kextload /System/Library/Extensions/AppleHDA.kext

