#!/bin/bash

# Note: `workspaceFolder` is the folder that contains the Dockerfile
#       The name is inherited from VSCode meaning.
#       See vscode-user-settings.json.example

docker run ednutting/jekyll-haskell-stack:dev /bin/bash -c "stack --version"
