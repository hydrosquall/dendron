#!/bin/bash

git reset --hard
git clean -f
git pull

# don't install in workspace
rm ../../package.json
# conform to vscode naming  convention
sed  -ibak 's/@dendronhq.plugin-core/dendron/' package.json
sed  -ibak 's/out\/extension/dist\/extension/' package.json

cat package.json | jq '.repository = { "url": "https://github.com/dendronhq/dendron.git", "type": "git" }' > tmp.json
mv tmp.json package.json

#./scripts/sync_static.sh
yarn install --no-lockfile
vsce package --yarn