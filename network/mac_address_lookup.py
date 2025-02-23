#!/usr/bin/env python3

import subprocess
import re
import argparse

def get_arp_table():
    """Retrieves the ARP table using the 'arp -a' command."""
    try:
        result = subprocess.run(['arp', '-a'], capture_output=True, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error retrieving ARP table: {e}")
        return None
    except FileNotFoundError:
        print("Error: 'arp' command not found. Make sure it is installed.")
        return None

def find_mac_address(arp_table, ip_address):
    """Finds the MAC address associated with a given IP address in the ARP table."""
    if arp_table is None:
        return None

    lines = arp_table.splitlines()
    for line in lines:
        match = re.search(r'\((\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\)\s+at\s+([0-9a-fA-F:]+)', line)
        if match:
            ip, mac = match.groups()
            if ip == ip_address:
                return mac
    return None

def main():
    parser = argparse.ArgumentParser(description="Look up MAC address for a given IP address.")
    parser.add_argument("ip_address", help="The IP address to look up.")
    args = parser.parse_args()

    arp_table = get_arp_table()
    if arp_table:
        mac_address = find_mac_address(arp_table, args.ip_address)
        if mac_address:
            print(f"MAC address for {args.ip_address}: {mac_address}")
        else:
            print(f"MAC address not found for {args.ip_address}.")

if __name__ == "__main__":
    main()
