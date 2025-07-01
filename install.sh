#!/bin/bash

REPO_URL="https://github.com/Julian-Zillner/Toolbox.git"
CLONE_DIR="/opt/toolbox"

if [ -d "$CLONE_DIR/.git" ]; then
    echo "Repository already exists. Pulling the latest changes..."
    git -C "$CLONE_DIR" pull
else
    echo "Cloning the toolbox repository into $CLONE_DIR..."
    git clone "$REPO_URL" "$CLONE_DIR"
fi


chmod -R +x "$CLONE_DIR/Scripts"

echo "Toolbox scripts are available in: $CLONE_DIR/Scripts"
echo "To update them in the future, run: git -C $CLONE_DIR pull"
