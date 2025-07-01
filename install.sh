#!/bin/bash

REPO_ZIP_URL="https://github.com/Julian-Zillner/Toolbox/archive/refs/heads/main.zip"
INSTALL_DIR="/opt/toolbox"
TMP_ZIP="/tmp/toolbox-main.zip"
UPDATE_SCRIPT_PATH="/usr/local/bin/toolbox-update"


if ! command -v unzip >/dev/null 2>&1; then
    echo "'unzip' is not installed. Please install it first (e.g. 'sudo apt install unzip')."
    exit 1
fi


echo "Downloading latest Toolbox version..."
curl -L -o "$TMP_ZIP" "$REPO_ZIP_URL"
if [ $? -ne 0 ]; then
    echo "Download failed. Please check your internet connection or the URL."
    exit 1
fi


echo "Extracting..."
rm -rf /tmp/Toolbox-main
unzip -oq "$TMP_ZIP" -d /tmp/


rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
mv /tmp/Toolbox-main/Scripts "$INSTALL_DIR/"


chmod -R +x "$INSTALL_DIR"


echo "#!/bin/bash
curl -L -o \"$TMP_ZIP\" \"$REPO_ZIP_URL\"
unzip -oq \"$TMP_ZIP\" -d /tmp/
rm -rf \"$INSTALL_DIR\"
mkdir -p \"$INSTALL_DIR\"
mv /tmp/Toolbox-main/Scripts \"$INSTALL_DIR/\"
chmod -R +x \"$INSTALL_DIR\"
echo \"Toolbox updated successfully.\"
" > "$UPDATE_SCRIPT_PATH"

chmod +x "$UPDATE_SCRIPT_PATH"

rm -f "$TMP_ZIP"

echo "Toolbox installed to: $INSTALL_DIR"
echo "You can run scripts from: $INSTALL_DIR/Scripts"
echo "To update the toolbox in the future, just run: toolbox-update"
