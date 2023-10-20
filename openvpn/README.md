# OpenVPN Event Logger Script

## Overview

This script serves as a client-connect and client-disconnect script for OpenVPN. It logs OpenVPN events to syslog and sends detailed information via email.

## Disclaimer

**DISCLAIMER:** This script logs IP information and should not be used in situations where privacy is a primary concern.

## Usage

1. **Configure OpenVPN:**
    - Set this script as the `client-connect` and `client-disconnect` script in your OpenVPN server (server.conf) configuration.

    ```conf
    client-connect /path/to/your/openvpn-event-logger.sh
    client-disconnect /path/to/your/openvpn-event-logger.sh
    script-security 2
    ```

2. **File Permissions:**
    - Ensure that the script has the necessary execute permissions.

3. **Dependencies:**
    - Ensure that the `logger` and `mail` commands are available on your system.

4. **Customization:**
    - Customize the `from_address` and `to_address` variables with appropriate email addresses.

## Script Variables

- `script_type`: The type of OpenVPN script event (client-connect or client-disconnect).
- `trusted_ip`: IP address of the connected client.
- `untrusted_ip`: IP address of the untrusted network.
- `common_name`: Common name of the client certificate.
- `ifconfig_pool_remote_ip`: Virtual IP address assigned to the client.
- `dev`: The network device name.
- `ifconfig_local`: Local IP address assigned to the OpenVPN server.
- `HOSTNAME`: Hostname of the OpenVPN server.

## Example

```conf
client-connect /path/to/your/openvpn-event-logger.sh
client-disconnect /path/to/your/openvpn-event-logger.sh
script-security 2
