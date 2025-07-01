#!/bin/bash

SCRIPT_PATH="/usr/local/bin/auto-update.sh"
CRON_ENTRY="0 3 * * * $SCRIPT_PATH >> /var/log/auto-update.log 2>&1"

function install() {
    cat << 'EOF' > "$SCRIPT_PATH"
#!/bin/bash
echo "=== Update gestartet: \$(date) ==="
/usr/bin/apt update -y
/usr/bin/apt upgrade -y
/usr/bin/apt autoremove -y
echo "=== Update abgeschlossen: \$(date) ==="
EOF

    chmod +x "$SCRIPT_PATH"

    if crontab -l 2>/dev/null | grep -Fq "$SCRIPT_PATH"; then
        echo "Cronjob allready exist."
    else
        (crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -
        echo "Cronjob successfully added: $CRON_ENTRY"
    fi
}

function remove() {
    crontab -l 2>/dev/null | grep -vF "$SCRIPT_PATH" | crontab -
    echo "Cronjob deleted successfully."

    if [ -f "$SCRIPT_PATH" ]; then
        rm "$SCRIPT_PATH"
        echo "Script $SCRIPT_PATH successfully deleted."
    else
        echo "Script $SCRIPT_PATH does not exist."
    fi
}

case "$1" in
    --install)
        install
        ;;
    --remove)
        remove
        ;;
    *)
        echo "Usage: $0 --install | --remove"
        ;;
esac
