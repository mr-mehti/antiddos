# ANTI DDOS

iptables -A FORWARD -p tcp --syn -m limit --limit 1/second -j ACCEPT

iptables -A FORWARD -p udp -m limit --limit 1/second -j ACCEPT

iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT

iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

iptables -A INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT



# Reject spoofed packets

iptables -A INPUT -s 10.0.0.0/8 -j DROP

iptables -A INPUT -s 169.254.0.0/16 -j DROP

iptables -A INPUT -s 172.16.0.0/12 -j DROP

iptables -A INPUT -s 127.0.0.0/8 -j DROP



iptables -A INPUT -s 224.0.0.0/4 -j DROP

iptables -A INPUT -d 224.0.0.0/4 -j DROP

iptables -A INPUT -s 240.0.0.0/5 -j DROP

iptables -A INPUT -d 240.0.0.0/5 -j DROP

iptables -A INPUT -s 0.0.0.0/8 -j DROP

iptables -A INPUT -d 0.0.0.0/8 -j DROP

iptables -A INPUT -d 239.255.255.0/24 -j DROP

iptables -A INPUT -d 255.255.255.255 -j DROP



# Drop all invalid packets

iptables -A INPUT -m state --state INVALID -j DROP

iptables -A FORWARD -m state --state INVALID -j DROP

iptables -A OUTPUT -m state --state INVALID -j DROP



# Drop excessive RST packets to avoid smurf attacks

iptables -A INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT

