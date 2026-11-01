#!/bin/bash
export PATH="/usr/sbin:/usr/local/bin:$PATH"
sudo iptables-legacy -P FORWARD ACCEPT 2>/dev/null || true
BR=$(ip -br link | awk '/br-/{print $1; exit}' | sed 's/@.*//')
if [ -n "$BR" ]; then
  sudo iptables-legacy -C FORWARD -i "$BR" -o "$BR" -j ACCEPT 2>/dev/null || sudo iptables-legacy -I FORWARD 1 -i "$BR" -o "$BR" -j ACCEPT
fi
sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null
