#!/bin/bash

# set -x
# OpenVPN event logger script - see README for more details
#
# This script logs OpenVPN events to syslog and sends detailed information via email.
# It is designed to be used as a client-connect and client-disconnect script in OpenVPN.
# Author: Wesley van Rossumn (wesley@_sernate.com_)
#
# DISCLAIMER: This script logs IP information and should not be used in situations where privacy is a concern.
#

# Set the email addresses
from_address="from@domain.com"
to_address="monitor@domain2.com"

# Function to log events to syslog and send email
log_and_email_event() {
    local event_type="$1"
    local client_ip="$2"
    local common_name="$3"
    local hostname="$4"

    # Log to syslog
    logger -t openvpn Client-"$event_type - Client: $common_name, IP: $client_ip, Hostname: $hostname"

    # Send email using mail command with detailed information
    echo -e "OpenVPN Event:\n\
    Event Type: $event_type\n\
    Common Name: $common_name\n\
    Client IP: $client_ip\n\
    Hostname: $hostname\n\
    Script Type: $script_type\n\
    Trusted IP: $trusted_ip\n\
    Untrusted IP: $untrusted_ip\n\
    Virtual IP: $ifconfig_pool_remote_ip\n\
    Device: $dev\n\
    Local IP: $ifconfig_local\n" | mail -s "OpenVPN Event" -r "$from_address" "$to_address"
}

# Determine the event type based on the script_type environment variable
if [ "$script_type" == "client-connect" ]; then
    event_type="CONNECT"
elif [ "$script_type" == "client-disconnect" ]; then
    event_type="DISCONNECT"
else
    logger -t openvpn "Unknown script type: $script_type"
    exit 1
fi

# Log the event and send email
log_and_email_event "$event_type" "$trusted_ip" "$common_name" "$HOSTNAME"

exit 0
