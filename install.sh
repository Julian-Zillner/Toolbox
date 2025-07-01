#!/bin/bash

REPO_ZIP_URL="https://github.com/Julian-Zillner/Toolbox/archive/refs/heads/main.zip"
INSTALL_DIR="/opt/toolbox"
TMP_DIR="/tmp/Toolbox-main"
TMP_ZIP="/tmp/toolbox-main.zip"
UPDATE_SCRIPT_PATH="/usr/local/bin/toolbox-update"
LOCAL_INSTALL_SCRIPT="/usr/local/bin/toolbox-install.sh"  


if ! command -v unzip >/dev/null 2>&1; then
    echo "'unzip' is not installed. Please install it first (e.g. 'sudo apt install unzip')."
    exit 1
fi

echo "Downloading latest Toolbox version..."
curl -L -o "$TMP_ZIP" "$REPO_ZIP_URL" || { echo "Download failed."; exit 1; }

rm -rf "$TMP_DIR"
unzip -oq "$TMP_ZIP" -d /tmp/


rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
mv "$TMP_DIR/Scripts" "$INSTALL_DIR/"


chmod -R +x "$INSTALL_DIR"


cp "$TMP_DIR/install.sh" "$LOCAL_INSTALL_SCRIPT"
chmod +x "$LOCAL_INSTALL_SCRIPT"


cat > "$UPDATE_SCRIPT_PATH" << EOF
#!/bin/bash
curl -L -o "$TMP_ZIP" "$REPO_ZIP_URL" || { echo "Download failed."; exit 1; }
rm -rf "$TMP_DIR"
unzip -oq "$TMP_ZIP" -d /tmp/
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
mv "$TMP_DIR/Scripts" "$INSTALL_DIR/"
chmod -R +x "$INSTALL_DIR"
cp "$TMP_DIR/install.sh" "$LOCAL_INSTALL_SCRIPT"
chmod +x "$LOCAL_INSTALL_SCRIPT"
rm -f "$TMP_ZIP"
echo "Toolbox updated successfully."
EOF

chmod +x "$UPDATE_SCRIPT_PATH"
rm -f "$TMP_ZIP"

echo "Toolbox installed to: $INSTALL_DIR"
echo "Scripts can be run from: $INSTALL_DIR/Scripts"
echo "To update toolbox, run: toolbox-updated"
echo "To update Install Script, run: toolbox-install.sh"
