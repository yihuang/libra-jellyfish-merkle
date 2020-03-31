#!/bin/sh
LIBRA_PATH=${LIBRA_PATH:-"$HOME/src/libra"}

if [ ! -z "`git status --porcelain`" ]; then
    echo 'Working directory not clean'
    exit 1
fi

for name in storage/jellyfish-merkle crypto/crypto crypto/crypto-derive common/nibble common/lcs common/proptest-helpers; do
    rsync -rv --delete $LIBRA_PATH/$name/ ./`basename $name`/
done
mkdir -p types/src
rsync -rv --delete $LIBRA_PATH/types/src/proto/ types/src/proto/
cp $LIBRA_PATH/types/build.rs types/
cp $LIBRA_PATH/types/Cargo.toml types/
# git apply -3 ./patch.diff
