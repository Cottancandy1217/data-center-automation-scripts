 #!/bin/bash

# port_status_check.sh
# Checks the status of switch ports on a Cisco switch.

# Configuration
SWITCH_IP="192.168.1.10"  # Replace with your switch's IP address
SWITCH_USER="admin"         # Replace with your switch username
SWITCH_PASSWORD="password"     # Replace with your switch password
ENABLE_SECRET="enable_secret" # Replace with your enable secret (if applicable)

# Function to check port status
check_port_status() {
  # Log in to the switch and execute the command
  sshpass -p "$SWITCH_PASSWORD" ssh -o StrictHostKeyChecking=no "$SWITCH_USER@$SWITCH_IP" << EOF
enable
$ENABLE_SECRET
show interfaces status
exit
EOF
}

# Function to check specific port status
check_specific_port_status() {
  PORT="$1"
  sshpass -p "$SWITCH_PASSWORD" ssh -o StrictHostKeyChecking=no "$SWITCH_USER@$SWITCH_IP" << EOF
enable
$ENABLE_SECRET
show interfaces status interface $PORT
exit
EOF
}

# Main script logic
if [[ -z "$1" ]]; then #checks if there is any command line argument
  check_port_status
else
  check_specific_port_status "$1"
fi
