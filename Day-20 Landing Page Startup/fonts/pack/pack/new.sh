#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}

create_user() {
    echo -n "Enter username to create: "
    read username
    if id "$username" &>/dev/null; then
        echo "User already exists."
    else
        sudo useradd -m "$username" && echo "User $username created."
        log "Created user $username"
    fi
}

ping_test() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 "$host" || error_exit "Ping failed"
}

fetch_url() {
    echo -n "Enter URL to fetch: "
    read url
    curl -s "$url" | head -n 20 || error_exit "Curl failed"
}

run_background_task() {
    echo "Running background task (sleep 30)..."
    (sleep 30 && echo "Background task complete!" >> "$LOGFILE") &
    echo "Background PID: $!"
}

show_logs() {
    echo -e "\n--- Logs ---"
    tail -n 50 "$LOGFILE"
}

show_menu() {
    echo -e "\n=== Mega Bash Toolkit Menu ==="
    local i=1
    MENU_OPTIONS=(
        [1]="Monitor System"
        [2]="Backup Home Directory"
        [3]="List Users"
        [4]="Create User"
        [5]="Ping Test"
        [6]="Fetch URL"
        [7]="Run Background Task"
        [8]="View Logs"
        [9]="Exit"
    )
    for key in "${!MENU_OPTIONS[@]}"; do
        echo "$key) ${MENU_OPTIONS[$key]}"
    done
}

main_loop() {
    while true; do
        show_menu
        echo -n "Choose an option: "
        read choice
        case "$choice" in
            1) monitor_system ;;
            2) backup_home ;;
            3) list_users ;;
            4) create_user ;;
            5) ping_test ;;
            6) fetch_url ;;
            7) run_background_task ;;
            8) show_logs ;;
            9) echo "Exiting..."; break ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

trap 'echo -e "\nExiting due to interrupt."; exit 1' INT

# Ensure script is run with appropriate permissions
[[ $EUID -ne 0 ]] && echo "Warning: Some features may not work without sudo."

log "Script started"
main_loop
log "Script exited"
#!/bin/bash

# ===================================================
# Mega Bash Toolkit
# Features:
# - System monitoring
# - Backup utility
# - User management
# - Network diagnostics
# - Logging and error handling
# ===================================================

LOGFILE="/var/log/bash_toolkit.log"
BACKUP_DIR="/tmp/bash_toolkit_backups"
mkdir -p "$BACKUP_DIR"

declare -A MENU_OPTIONS

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

error_exit() {
    echo "ERROR: $1"
    log "ERROR: $1"
    exit 1
}

monitor_system() {
    echo -e "\n--- System Monitoring ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in users: $(who | wc -l)"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps aux --sort=-%mem | head -n 10
}

backup_home() {
    echo -e "\n--- Backing up home directory ---"
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$BACKUP_DIR/home_backup_$timestamp.tar.gz"
    tar -czf "$backup_file" "$HOME" || error_exit "Backup failed"
    echo "Backup saved to $backup_file"
    log "Backup created: $backup_file"
}

list_users() {
    echo -e "\n--- User Listing ---"
    awk -F: '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd
}
