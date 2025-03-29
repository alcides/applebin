#!/bin/zsh

set -x

version="v"
if [[ $(elan which lean) =~ "leanprover-community--lean---(.*)\/bin\/lean$" ]] then
  version+=$match
fi

if [[ version == "v" ]] then
  echo "elan which lean reported an unsupported Lean path:"
  echo $(elan which lean)
  exit 1
fi

lenloc=$(elan which lean)
chkloc=$(elan which leanchecker)
pkgloc=$(elan which leanpkg)

export LEAN_REPO="$HOME/Code/Support/lean"

# Set this to a local clone of leanprover-community/lean (that you don't mind being messed with!)
cd $LEAN_REPO
# Note that this is very destructive!!!
git clean -fdx
git switch master
git pull
git checkout $version
mkdir -p build/release
cd build/release
cmake -DCMAKE_PREFIX_PATH=/opt/homebrew/ -DCMAKE_INSTALL_PREFIX=$LEAN_REPO ../../src
make -j10
cd ../../
chmod u+w $lenloc $pkgloc $chkloc
cp bin/lean $lenloc
cp bin/leanpkg $pkgloc
cp build/release/checker/leanchecker $chkloc
chmod u-w $lenloc $pkgloc $chkloc