ps aux | grep 'coreaudio[d]' | awk '{print $2}' | xargs sudo kill
sudo kextunload /System/Library/Extensions/AppleHDA.kext
sudo kextload /System/Library/Extensions/AppleHDA.kext