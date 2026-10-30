#!/bin/bash

# ==============================================================================
#                      NEXUS ULTIMATE MULTI-PURPOSE SUITE v5.0
#                      Made by TahseenMahmud Officials
# ==============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

pause() {
    echo -e "\n${YELLOW}Press [ENTER] to return to menu...${NC}"
    read -r
}

get_command_count() {
    compgen -c | sort -u | wc -l
}

# ==============================================================================
# MENU 1: SYSTEM DIAGNOSTICS & MANAGEMENT (Options 1 - 10)
# ==============================================================================
sys_mgmt_menu() {
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "              ${CYAN}[ 1. SYSTEM DIAGNOSTICS & MANAGEMENT ]${NC}"
        echo -e "${RED}================================================================${NC}"
        echo -e "  ${WHITE}[${RED}1${WHITE}] ${GREEN}OS & Kernel Information${NC}"
        echo -e "  ${WHITE}[${RED}2${WHITE}] ${GREEN}CPU Info & Core Usage${NC}"
        echo -e "  ${WHITE}[${RED}3${WHITE}] ${GREEN}RAM & Swap Usage${NC}"
        echo -e "  ${WHITE}[${RED}4${WHITE}] ${GREEN}Storage Partitions & Free Space${NC}"
        echo -e "  ${WHITE}[${RED}5${WHITE}] ${GREEN}System Uptime & Load Averages${NC}"
        echo -e "  ${WHITE}[${RED}6${WHITE}] ${GREEN}Hardware Architecture & Vendor${NC}"
        echo -e "  ${WHITE}[${RED}7${WHITE}] ${GREEN}PCI Devices Summary${NC}"
        echo -e "  ${WHITE}[${RED}8${WHITE}] ${GREEN}USB Connected Devices${NC}"
        echo -e "  ${WHITE}[${RED}9${WHITE}] ${GREEN}Active System Services${NC}"
        echo -e "  ${WHITE}[${RED}10${WHITE}] ${GREEN}System Environment Variables${NC}"
        echo -e "  ${WHITE}[${RED}B${WHITE}] ${YELLOW}BACK TO MAIN MENU${NC}"
        echo -e "${RED}================================================================${NC}"

        echo -ne "${YELLOW}COMMAND >> ${NC}"
        read -r raw_opt
        opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$opt" in
            1) uname -a && cat /etc/os-release 2>/dev/null; pause ;;
            2) lscpu 2>/dev/null || cat /proc/cpuinfo; pause ;;
            3) free -h || cat /proc/meminfo; pause ;;
            4) df -h; pause ;;
            5) uptime; pause ;;
            6) arch || uname -m; pause ;;
            7) lspci 2>/dev/null || echo "[!] lspci command not available on this system."; pause ;;
            8) lsusb 2>/dev/null || echo "[!] lsusb command not available on this system."; pause ;;
            9) systemctl list-units --type=service --state=running 2>/dev/null || service --status-all 2>/dev/null || ps -ef; pause ;;
            10) printenv; pause ;;
            B) return ;;
            *) echo -e "${RED}Invalid selection.${NC}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MENU 2: NETWORK & RECON TOOLS (Options 11 - 20)
# ==============================================================================
net_recon_menu() {
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "                 ${CYAN}[ 2. NETWORK & RECON TOOLS ]${NC}"
        echo -e "${RED}================================================================${NC}"
        echo -e "  ${WHITE}[${RED}11${WHITE}] ${GREEN}Local IP Interfaces & Addresses${NC}"
        echo -e "  ${WHITE}[${RED}12${WHITE}] ${GREEN}Public WAN IP Lookup${NC}"
        echo -e "  ${WHITE}[${RED}13${WHITE}] ${GREEN}Ping Remote Host${NC}"
        echo -e "  ${WHITE}[${RED}14${WHITE}] ${GREEN}Traceroute Route Hop Test${NC}"
        echo -e "  ${WHITE}[${RED}15${WHITE}] ${GREEN}DNS Lookup (NSLOOKUP / DIG)${NC}"
        echo -e "  ${WHITE}[${RED}16${WHITE}] ${GREEN}Active Listening TCP/UDP Ports${NC}"
        echo -e "  ${WHITE}[${RED}17${WHITE}] ${GREEN}Routing Table & Default Gateway${NC}"
        echo -e "  ${WHITE}[${RED}18${WHITE}] ${GREEN}ARP Cache Table${NC}"
        echo -e "  ${WHITE}[${RED}19${WHITE}] ${GREEN}Domain WHOIS Information${NC}"
        echo -e "  ${WHITE}[${RED}20${WHITE}] ${GREEN}Quick Local Port Check (Netcat/Bash)${NC}"
        echo -e "  ${WHITE}[${RED}B${WHITE}] ${YELLOW}BACK TO MAIN MENU${NC}"
        echo -e "${RED}================================================================${NC}"

        echo -ne "${YELLOW}COMMAND >> ${NC}"
        read -r raw_opt
        opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$opt" in
            11) ip addr 2>/dev/null || ifconfig; pause ;;
            12) curl -s https://ifconfig.me || wget -qO- https://api.ipify.org; echo ""; pause ;;
            13) echo -ne "Enter target host/IP: "; read -r target; ping -c 4 "$target"; pause ;;
            14) echo -ne "Enter target host: "; read -r target; traceroute "$target" 2>/dev/null || tracepath "$target" 2>/dev/null || ping -c 1 -R "$target"; pause ;;
            15) echo -ne "Enter domain: "; read -r domain; dig "$domain" +short 2>/dev/null || nslookup "$domain"; pause ;;
            16) netstat -tuln 2>/dev/null || ss -tuln || cat /proc/net/tcp; pause ;;
            17) ip route 2>/dev/null || route -n; pause ;;
            18) ip neighbor 2>/dev/null || arp -a; pause ;;
            19) echo -ne "Enter domain: "; read -r domain; whois "$domain" 2>/dev/null || nc -z -v whois.verisign-grs.com 43; pause ;;
            20) echo -ne "Target IP & Port (e.g. 127.0.0.1 80): "; read -r tip tport; (echo >/dev/tcp/$tip/$tport) >/dev/null 2>&1 && echo "[+] Port $tport is OPEN" || echo "[-] Port $tport is CLOSED/UNREACHABLE"; pause ;;
            B) return ;;
            *) echo -e "${RED}Invalid selection.${NC}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MENU 3: PROCESS & SECURITY MANAGEMENT (Options 21 - 30)
# ==============================================================================
proc_sec_menu() {
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "            ${CYAN}[ 3. PROCESS & SECURITY MANAGEMENT ]${NC}"
        echo -e "${RED}================================================================${NC}"
        echo -e "  ${WHITE}[${RED}21${WHITE}] ${GREEN}Top CPU Consuming Processes${NC}"
        echo -e "  ${WHITE}[${RED}22${WHITE}] ${GREEN}Top RAM Consuming Processes${NC}"
        echo -e "  ${WHITE}[${RED}23${WHITE}] ${GREEN}Kill Process by PID${NC}"
        echo -e "  ${WHITE}[${RED}24${WHITE}] ${GREEN}Kill Process by Name${NC}"
        echo -e "  ${WHITE}[${RED}25${WHITE}] ${GREEN}Check Logged In Users${NC}"
        echo -e "  ${WHITE}[${RED}26${WHITE}] ${GREEN}SSH Auth Logs Inspection${NC}"
        echo -e "  ${WHITE}[${RED}27${WHITE}] ${GREEN}View Active User Cron Jobs${NC}"
        echo -e "  ${WHITE}[${RED}28${WHITE}] ${GREEN}Firewall Status (UFW/Iptables)${NC}"
        echo -e "  ${WHITE}[${RED}29${WHITE}] ${GREEN}System Kernel Audit Logs (dmesg)${NC}"
        echo -e "  ${WHITE}[${RED}30${WHITE}] ${GREEN}Inspect Open File Handles (lsof)${NC}"
        echo -e "  ${WHITE}[${RED}B${WHITE}] ${YELLOW}BACK TO MAIN MENU${NC}"
        echo -e "${RED}================================================================${NC}"

        echo -ne "${YELLOW}COMMAND >> ${NC}"
        read -r raw_opt
        opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$opt" in
            21) ps aux --sort=-%cpu | head -n 15; pause ;;
            22) ps aux --sort=-%mem | head -n 15; pause ;;
            23) echo -ne "Enter PID to kill: "; read -r pid; kill -9 "$pid" && echo "Successfully terminated PID $pid"; pause ;;
            24) echo -ne "Enter Process Name: "; read -r pname; pkill -f "$pname" && echo "Successfully terminated process name $pname"; pause ;;
            25) w || who; pause ;;
            26) tail -n 25 /var/log/auth.log 2>/dev/null || journalctl _COMM=sshd -n 25 2>/dev/null || echo "[!] Auth log restricted."; pause ;;
            27) crontab -l 2>/dev/null || echo "No crontab for current user."; pause ;;
            28) ufw status 2>/dev/null || iptables -L 2>/dev/null || echo "[!] Firewall control tools not found."; pause ;;
            29) dmesg | tail -n 25; pause ;;
            30) lsof 2>/dev/null | head -n 25 || echo "[!] lsof not installed."; pause ;;
            B) return ;;
            *) echo -e "${RED}Invalid selection.${NC}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MENU 4: FILE SYSTEM & MAINTENANCE (Options 31 - 40)
# ==============================================================================
file_maint_menu() {
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "              ${CYAN}[ 4. FILE SYSTEM & MAINTENANCE ]${NC}"
        echo -e "${RED}================================================================${NC}"
        echo -e "  ${WHITE}[${RED}31${WHITE}] ${GREEN}Clean /tmp Directory safely${NC}"
        echo -e "  ${WHITE}[${RED}32${WHITE}] ${GREEN}Find Top 10 Largest Files in Current Path${NC}"
        echo -e "  ${WHITE}[${RED}33${WHITE}] ${GREEN}List Files Modified in Last 24 Hours${NC}"
        echo -e "  ${WHITE}[${RED}34${WHITE}] ${GREEN}Check File Inode Usage${NC}"
        echo -e "  ${WHITE}[${RED}35${WHITE}] ${GREEN}Compress Folder to .tar.gz Archive${NC}"
        echo -e "  ${WHITE}[${RED}36${WHITE}] ${GREEN}Decompress Archive (.tar.gz / .zip)${NC}"
        echo -e "  ${WHITE}[${RED}37${WHITE}] ${GREEN}Search Files for Text Keyword (grep)${NC}"
        echo -e "  ${WHITE}[${RED}38${WHITE}] ${GREEN}Clean APT Package Cache${NC}"
        echo -e "  ${WHITE}[${RED}39${WHITE}] ${GREEN}Detailed Directory Listing (ls -la)${NC}"
        echo -e "  ${WHITE}[${RED}40${WHITE}] ${GREEN}Generate File SHA256 Checksum${NC}"
        echo -e "  ${WHITE}[${RED}B${WHITE}] ${YELLOW}BACK TO MAIN MENU${NC}"
        echo -e "${RED}================================================================${NC}"

        echo -ne "${YELLOW}COMMAND >> ${NC}"
        read -r raw_opt
        opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$opt" in
            31) find /tmp -mindepth 1 -delete 2>/dev/null && echo "[+] /tmp cleaned."; pause ;;
            32) du -ah . 2>/dev/null | sort -rh | head -n 10; pause ;;
            33) find . -maxdepth 3 -mtime -1 -print 2>/dev/null | head -n 25; pause ;;
            34) df -i; pause ;;
            35) echo -ne "Enter folder path to compress: "; read -r fpath; tar -czvf "archive_$(date +%s).tar.gz" "$fpath"; pause ;;
            36) echo -ne "Enter archive filename: "; read -r apath; tar -xzvf "$apath" 2>/dev/null || unzip "$apath"; pause ;;
            37) echo -ne "Enter search keyword: "; read -r kw; grep -rnw '.' -e "$kw" 2>/dev/null | head -n 25; pause ;;
            38) apt-get clean 2>/dev/null || apt clean 2>/dev/null || echo "[!] Not a Debian/Ubuntu APT environment."; pause ;;
            39) ls -la; pause ;;
            40) echo -ne "Enter target file path: "; read -r tfile; sha256sum "$tfile" 2>/dev/null || shasum -a 256 "$tfile"; pause ;;
            B) return ;;
            *) echo -e "${RED}Invalid selection.${NC}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MENU 5: DEVELOPER & BENCHMARK SUITE (Options 41 - 50)
# ==============================================================================
dev_bench_menu() {
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "             ${CYAN}[ 5. DEVELOPER & BENCHMARK SUITE ]${NC}"
        echo -e "${RED}================================================================${NC}"
        echo -e "  ${WHITE}[${RED}41${WHITE}] ${GREEN}Check Language Runtimes (Python, Node, Go, Rust)${NC}"
        echo -e "  ${WHITE}[${RED}42${WHITE}] ${GREEN}Disk I/O Write Speed Benchmark${NC}"
        echo -e "  ${WHITE}[${RED}43${WHITE}] ${GREEN}Git Status Inspection${NC}"
        echo -e "  ${WHITE}[${RED}44${WHITE}] ${GREEN}Docker Container Status${NC}"
        echo -e "  ${WHITE}[${RED}45${WHITE}] ${GREEN}SSL Certificate Expiration Date Checker${NC}"
        echo -e "  ${WHITE}[${RED}46${WHITE}] ${GREEN}HTTP Headers Response Inspector${NC}"
        echo -e "  ${WHITE}[${RED}47${WHITE}] ${GREEN}Systemd Journal Logs${NC}"
        echo -e "  ${WHITE}[${RED}48${WHITE}] ${GREEN}Base64 Encode String${NC}"
        echo -e "  ${WHITE}[${RED}49${WHITE}] ${GREEN}Base64 Decode String${NC}"
        echo -e "  ${WHITE}[${RED}50${WHITE}] ${GREEN}Generate Secure Random 32-Char Password${NC}"
        echo -e "  ${WHITE}[${RED}B${WHITE}] ${YELLOW}BACK TO MAIN MENU${NC}"
        echo -e "${RED}================================================================${NC}"

        echo -ne "${YELLOW}COMMAND >> ${NC}"
        read -r raw_opt
        opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$opt" in
            41)
                echo "--- Runtime Versions ---"
                python3 --version 2>/dev/null || echo "Python3: Not found"
                node -v 2>/dev/null || echo "Node.js: Not found"
                go version 2>/dev/null || echo "Go: Not found"
                rustc --version 2>/dev/null || echo "Rust: Not found"
                pause
                ;;
            42) dd if=/dev/zero of=bench_test.img bs=1M count=256 conv=fdatasync 2>&1; rm -f bench_test.img; pause ;;
            43) git status 2>/dev/null || echo "[!] Not a Git workspace."; pause ;;
            44) docker ps 2>/dev/null || echo "[!] Docker engine not active."; pause ;;
            45) echo -ne "Enter domain (e.g. google.com): "; read -r sdom; openssl s_client -connect "$sdom":443 -servername "$sdom" </dev/null 2>/dev/null | openssl x509 -noout -dates; pause ;;
            46) echo -ne "Enter full URL: "; read -r curl_url; curl -I -L "$curl_url"; pause ;;
            47) journalctl -n 25 --no-pager 2>/dev/null || echo "[!] journalctl unavailable."; pause ;;
            48) echo -ne "Text to encode: "; read -r raw_txt; echo -n "$raw_txt" | base64; pause ;;
            49) echo -ne "Base64 to decode: "; read -r b64_txt; echo "$b64_txt" | base64 -d; echo ""; pause ;;
            50) tr -dc 'A-Za-z0-9!@#%^&*' < /dev/urandom | head -c 32; echo ""; pause ;;
            B) return ;;
            *) echo -e "${RED}Invalid selection.${NC}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MENU 6: DYNAMIC COMMAND ENGINE (Access to 500+ System Binaries)
# ==============================================================================
command_engine() {
    while true; do
        clear
        echo -e "${CYAN}================================================================${NC}"
        echo -e "                 ${WHITE}[ NEXUS COMMAND ENGINE ($TOTAL_CMDS SYSTEM TOOLS) ]${NC}"
        echo -e "${CYAN}================================================================${NC}"
        echo -e "  Type any command (e.g., 'awk', 'sed', 'grep', 'curl', 'htop')."
        echo -e "  Type ${YELLOW}search <keyword>${NC} to query system utilities."
        echo -e "  Type ${RED}B${NC} to return."
        echo -e "${CYAN}================================================================${NC}"

        echo -ne "${YELLOW}NEXUS-CMD >> ${NC}"
        read -r raw_input
        input=$(echo "$raw_input" | tr -d '\r')

        case "$input" in
            [Bb]) return ;;
            search*)
                keyword=$(echo "$input" | cut -d' ' -f2-)
                if [ -z "$keyword" ] || [ "$keyword" == "search" ]; then
                    echo -e "${RED}Usage: search <keyword>${NC}"
                else
                    echo -e "\n${CYAN}--- Matching Tools ---${NC}"
                    compgen -c | sort -u | grep -i "$keyword" | head -n 40
                fi
                pause
                ;;
            "") continue ;;
            *)
                if command -v "${input%% *}" >/dev/null 2>&1; then
                    echo -e "${GREEN}Executing: $input${NC}\n"
                    eval "$input"
                else
                    echo -e "${RED}Command '$input' not found.${NC}"
                fi
                pause
                ;;
        esac
    done
}

# ==============================================================================
# MENU 7: MULTI VPS MANAGER INTEGRATION (QEMU / Cloud-Init VM Suite)
# ==============================================================================
multi_vps_manager() {
    # Check dependencies for Multi-VM manager
    local deps=("qemu-system-x86_64" "wget" "cloud-localds" "qemu-img")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}[ERROR] Missing dependencies for VM Manager: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}[INFO] On Ubuntu/Debian, try: sudo apt install qemu-system cloud-image-utils wget qemu-utils${NC}"
        pause
        return
    fi

    # Initialize paths & configs
    local vm_mgr_dir="${VM_DIR:-$HOME/vms}"
    mkdir -p "$vm_mgr_dir"

    declare -A vm_os_options=(
        ["Ubuntu 22.04"]="ubuntu|jammy|https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img|ubuntu22|ubuntu|ubuntu"
        ["Ubuntu 24.04"]="ubuntu|noble|https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img|ubuntu24|ubuntu|ubuntu"
        ["Debian 11"]="debian|bullseye|https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2|debian11|debian|debian"
        ["Debian 12"]="debian|bookworm|https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2|debian12|debian|debian"
        ["Fedora 40"]="fedora|40|https://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-40-1.14.x86_64.qcow2|fedora40|fedora|fedora"
        ["CentOS Stream 9"]="centos|stream9|https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2|centos9|centos|centos"
        ["AlmaLinux 9"]="almalinux|9|https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2|almalinux9|alma|alma"
        ["Rocky Linux 9"]="rockylinux|9|https://download.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2|rocky9|rocky|rocky"
    )

    # Helper functions local to Multi-VM Manager
    local_print_status() {
        local type=$1
        local message=$2
        case $type in
            "INFO") echo -e "\033[1;34m[INFO]\033[0m $message" ;;
            "WARN") echo -e "\033[1;33m[WARN]\033[0m $message" ;;
            "ERROR") echo -e "\033[1;31m[ERROR]\033[0m $message" ;;
            "SUCCESS") echo -e "\033[1;32m[SUCCESS]\033[0m $message" ;;
            "INPUT") echo -e "\033[1;36m[INPUT]\033[0m $message" ;;
            *) echo "[$type] $message" ;;
        esloan_dummy=""
    }

    local_validate_input() {
        local type=$1
        local value=$2
        case $type in
            "number")
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then echo -e "\033[1;31m[ERROR]\033[0m Must be a number"; return 1; fi ;;
            "size")
                if ! [[ "$value" =~ ^[0-9]+[GgMm]$ ]]; then echo -e "\033[1;31m[ERROR]\033[0m Must be a size with unit (e.g., 100G, 512M)"; return 1; fi ;;
            "port")
                if ! [[ "$value" =~ ^[0-9]+$ ]] || [ "$value" -lt 23 ] || [ "$value" -gt 65535 ]; then echo -e "\033[1;31m[ERROR]\033[0m Must be a valid port number (23-65535)"; return 1; fi ;;
            "name")
                if ! [[ "$value" =~ ^[a-zA-Z0-9_-]+$ ]]; then echo -e "\033[1;31m[ERROR]\033[0m VM name can only contain letters, numbers, hyphens, and underscores"; return 1; fi ;;
            "username")
                if ! [[ "$value" =~ ^[a-z_][a-z0-9_-]*$ ]]; then echo -e "\033[1;31m[ERROR]\033[0m Username must start with a letter/underscore and contain valid characters"; return 1; fi ;;
        end
        esac
        return 0
    }

    get_vm_list() {
        find "$vm_mgr_dir" -name "*.conf" -exec basename {} .conf \; 2>/dev/null | sort
    }

    load_vm_config() {
        local vm_name=$1
        local config_file="$vm_mgr_dir/$vm_name.conf"
        if [[ -f "$config_file" ]]; then
            unset VM_NAME OS_TYPE CODENAME IMG_URL HOSTNAME USERNAME PASSWORD
            unset DISK_SIZE MEMORY CPUS SSH_PORT GUI_MODE PORT_FORWARDS IMG_FILE SEED_FILE CREATED
            source "$config_file"
            return 0
        else
            echo -e "\033[1;31m[ERROR]\033[0m Configuration for VM '$vm_name' not found"
            return 1
        fi
    }

    save_vm_config() {
        local config_file="$vm_mgr_dir/$VM_NAME.conf"
        cat > "$config_file" <<EOF
VM_NAME="$VM_NAME"
OS_TYPE="$OS_TYPE"
CODENAME="$CODENAME"
IMG_URL="$IMG_URL"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
PASSWORD="$PASSWORD"
DISK_SIZE="$DISK_SIZE"
MEMORY="$MEMORY"
CPUS="$CPUS"
SSH_PORT="$SSH_PORT"
GUI_MODE="$GUI_MODE"
PORT_FORWARDS="$PORT_FORWARDS"
IMG_FILE="$IMG_FILE"
SEED_FILE="$SEED_FILE"
CREATED="$CREATED"
EOF
        echo -e "\033[1;32m[SUCCESS]\033[0m Configuration saved."
    }

    setup_vm_image() {
        echo -e "\033[1;34m[INFO]\033[0m Preparing image..."
        mkdir -p "$vm_mgr_dir"
        if [[ -f "$IMG_FILE" ]]; then
            echo -e "\033[1;34m[INFO]\033[0m Image file already exists. Skipping download."
        else
            echo -e "\033[1;34m[INFO]\033[0m Downloading image from $IMG_URL..."
            wget --progress=bar:force "$IMG_URL" -O "$IMG_FILE.tmp" || { echo -e "\033[1;31m[ERROR]\033[0m Download failed"; return 1; }
            mv "$IMG_FILE.tmp" "$IMG_FILE"
        fi
        qemu-img resize "$IMG_FILE" "$DISK_SIZE" 2>/dev/null || {
            rm -f "$IMG_FILE"
            qemu-img create -f qcow2 -F qcow2 -b "$IMG_FILE" "$IMG_FILE.tmp" "$DISK_SIZE" 2>/dev/null || qemu-img create -f qcow2 "$IMG_FILE" "$DISK_SIZE"
            [ -f "$IMG_FILE.tmp" ] && mv "$IMG_FILE.tmp" "$IMG_FILE"
        }
        cat > user-data <<EOF
#cloud-config
hostname: $HOSTNAME
ssh_pwauth: true
disable_root: false
users:
  - name: $USERNAME
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    password: $(openssl passwd -6 "$PASSWORD" | tr -d '\n')
chpasswd:
  list: |
    root:$PASSWORD
    $USERNAME:$PASSWORD
  expire: false
EOF
        cat > meta-data <<EOF
instance-id: iid-$VM_NAME
local-hostname: $HOSTNAME
EOF
        cloud-localds "$SEED_FILE" user-data meta-data
        rm -f user-data meta-data
        echo -e "\033[1;32m[SUCCESS]\033[0m VM '$VM_NAME' ready."
    }

    create_new_vm() {
        echo -e "\033[1;34m[INFO]\033[0m Select an OS to set up:"
        local os_options_arr=()
        local i=1
        for os in "${!vm_os_options[@]}"; do
            echo "  $i) $os"
            os_options_arr[$i]="$os"
            ((i++))
        done
        while true; do
            read -p "Enter your choice (1-${#vm_os_options[@]}): " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#vm_os_options[@]} ]; then
                local os="${os_options_arr[$choice]}"
                IFS='|' read -r OS_TYPE CODENAME IMG_URL DEFAULT_HOSTNAME DEFAULT_USERNAME DEFAULT_PASSWORD <<< "${vm_os_options[$os]}"
                break
            fi
        done

        while true; do
            read -p "Enter VM name (default: $DEFAULT_HOSTNAME): " VM_NAME
            VM_NAME="${VM_NAME:-$DEFAULT_HOSTNAME}"
            if local_validate_input "name" "$VM_NAME"; then
                if [[ -f "$vm_mgr_dir/$VM_NAME.conf" ]]; then
                    echo "VM already exists."
                else
                    break
                fi
            fi
        done

        read -p "Enter hostname (default: $VM_NAME): " HOSTNAME
        HOSTNAME="${HOSTNAME:-$VM_NAME}"
        read -p "Enter username (default: $DEFAULT_USERNAME): " USERNAME
        USERNAME="${USERNAME:-$DEFAULT_USERNAME}"
        read -s -p "Enter password (default: $DEFAULT_PASSWORD): " PASSWORD
        PASSWORD="${PASSWORD:-$DEFAULT_PASSWORD}"
        echo
        read -p "Disk size (default: 20G): " DISK_SIZE
        DISK_SIZE="${DISK_SIZE:-20G}"
        read -p "Memory in MB (default: 2048): " MEMORY
        MEMORY="${MEMORY:-2048}"
        read -p "Number of CPUs (default: 2): " CPUS
        CPUS="${CPUS:-2}"
        read -p "SSH Port (default: 2222): " SSH_PORT
        SSH_PORT="${SSH_PORT:-2222}"
        read -p "Enable GUI mode? (y/n, default: n): " gui_input
        GUI_MODE=false
        [[ "$gui_input" =~ ^[Yy]$ ]] && GUI_MODE=true
        read -p "Additional port forwards (e.g., 8080:80, press Enter for none): " PORT_FORWARDS

        IMG_FILE="$vm_mgr_dir/$VM_NAME.img"
        SEED_FILE="$vm_mgr_dir/$VM_NAME-seed.iso"
        CREATED="$(date)"

        setup_vm_image
        save_vm_config
    }

    start_vm() {
        local vm_name=$1
        if load_vm_config "$vm_name"; then
            echo -e "\033[1;34m[INFO]\033[0m Starting VM: $vm_name (SSH: ssh -p $SSH_PORT $USERNAME@localhost)"
            [[ ! -f "$IMG_FILE" ]] && setup_vm_image
            
            local qemu_cmd=(
                qemu-system-x86_64 -enable-kvm -m "$MEMORY" -smp "$CPUS" -cpu host
                -drive "file=$IMG_FILE,format=qcow2,if=virtio"
                -drive "file=$SEED_FILE,format=raw,if=virtio"
                -boot order=c -device virtio-net-pci,netdev=n0
                -netdev "user,id=n0,hostfwd=tcp::$SSH_PORT-:22"
            )
            if [[ "$GUI_MODE" == true ]]; then
                qemu_cmd+=(-vga virtio -display gtk,gl=on)
            else
                qemu_cmd+=(-nographic -serial mon:stdio)
            fi
            "${qemu_cmd[@]}"
        fi
    }

    delete_vm() {
        local vm_name=$1
        read -p "Permanently delete VM '$vm_name'? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]] && load_vm_config "$vm_name"; then
            rm -f "$IMG_FILE" "$SEED_FILE" "$vm_mgr_dir/$vm_name.conf"
            echo -e "\033[1;32m[SUCCESS]\033[0m VM deleted."
        fi
    }

    # Main Submenu Loop for Multi-VM Manager
    while true; do
        clear
        echo -e "${RED}================================================================${NC}"
        echo -e "                 ${CYAN}[ MULTI VM MANAGER ]${NC}"
        echo -e "${RED}================================================================${NC}"
        
        local vms=($(get_vm_list))
        local vm_count=${#vms[@]}
        
        if [ $vm_count -gt 0 ]; then
            echo -e "${YELLOW}Existing VM(s):${NC}"
            for i in "${!vms[@]}"; do
                local status="Stopped"
                pgrep -f "qemu-system-x86_64.*${vms[$i]}" >/dev/null && status="Running"
                printf "  %2d) %s (%s)\n" $((i+1)) "${vms[$i]}" "$status"
            done
            echo
        fi

        echo "  1) Create a new VM"
        if [ $vm_count -gt 0 ]; then
            echo "  2) Start a VM"
            echo "  3) Stop a VM"
            echo "  4) Delete a VM"
        fi
        echo "  B) Back to Main Dashboard"
        echo -e "${RED}================================================================${NC}"
        
        read -ne 256 -p "$(echo -e "${YELLOW}VM-MGR >> ${NC}")" vm_opt
        vm_opt=$(echo "$vm_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

        case "$vm_opt" in
            B) return ;;
            1) create_new_vm; pause ;;
            2)
                if [ $vm_count -gt 0 ]; then
                    read -p "Enter VM number to start: " vm_num
                    [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ] && start_vm "${vms[$((vm_num-1))]}"
                fi
                ;;
            3)
                if [ $vm_count -gt 0 ]; then
                    read -p "Enter VM number to stop: " vm_num
                    [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ] && pkill -f "qemu-system-x86_64.*${vms[$((vm_num-1))]}"
                fi
                ;;
            4)
                if [ $vm_count -gt 0 ]; then
                    read -p "Enter VM number to delete: " vm_num
                    [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ] && delete_vm "${vms[$((vm_num-1))]}"
                fi
                ;;
            *) sleep 1 ;;
        esac
    done
}

# ==============================================================================
# MAIN DASHBOARD ENTRY POINT
# ==============================================================================
TOTAL_CMDS=$(get_command_count)

while true; do
    clear
    echo -e "${RED}================================================================${NC}"
    echo -e "${WHITE}   ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗${NC}"
    echo -e "${WHITE}   ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝${NC}"
    echo -e "${WHITE}   ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗${NC}"
    echo -e "${WHITE}   ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║${NC}"
    echo -e "${WHITE}   ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║${NC}"
    echo -e "${WHITE}   ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝${NC}"
    echo -e "                   ${CYAN}NEXUS Dashboard v5.0${NC}"
    echo -e "             ${RED}Made by TahseenMahmud Officials${NC}"
    echo -e "    ${GREEN}50 Real-Time Sub-Options | $TOTAL_CMDS System Binaries Indexed${NC}"
    echo -e "${RED}================================================================${NC}"
    echo -e "  ${WHITE}[${RED}1${WHITE}] ${CYAN}1. SYSTEM DIAGNOSTICS & MANAGEMENT  (Options 1-10)${NC}"
    echo -e "  ${WHITE}[${RED}2${WHITE}] ${CYAN}2. NETWORK & RECON TOOLS           (Options 11-20)${NC}"
    echo -e "  ${WHITE}[${RED}3${WHITE}] ${CYAN}3. PROCESS & SECURITY MANAGEMENT     (Options 21-30)${NC}"
    echo -e "  ${WHITE}[${RED}4${WHITE}] ${CYAN}4. FILE SYSTEM & MAINTENANCE        (Options 31-40)${NC}"
    echo -e "  ${WHITE}[${RED}5${WHITE}] ${CYAN}5. DEVELOPER & BENCHMARK SUITE       (Options 41-50)${NC}"
    echo -e "  ${WHITE}[${RED}6${WHITE}] ${YELLOW}6. DYNAMIC COMMAND ENGINE            (500+ CLI Engine)${NC}"
    echo -e "  ${WHITE}[${RED}7${WHITE}] ${MAGENTA}7. MULTI VPS MANAGER                 (QEMU VM Manager)${NC}"
    echo -e "  ${WHITE}[${RED}X${WHITE}] ${RED}EXIT DASHBOARD${NC}"
    echo -e "${RED}================================================================${NC}"
    
    echo -ne "${YELLOW}COMMAND >> ${NC}"
    read -r raw_opt
    main_opt=$(echo "$raw_opt" | tr -d '\r' | tr '[:lower:]' '[:upper:]')

    case "$main_opt" in
        1) sys_mgmt_menu ;;
        2) net_recon_menu ;;
        3) proc_sec_menu ;;
        4) file_maint_menu ;;
        5) dev_bench_menu ;;
        6) command_engine ;;
        7) multi_vps_manager ;;
        X) echo -e "${RED}Exiting...${NC}"; exit 0 ;;
        "") continue ;;
        *) echo -e "${RED}Invalid selection: '$main_opt'${NC}"; sleep 1 ;;
    esac
done
