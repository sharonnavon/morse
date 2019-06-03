#!/usr/bin/env python3

import socket

host = ""          # The server's hostname or IP address
port = 9999        # The port used by the server

s = socket.socket()
s.connect((host, port))

while True:
    data = s.recv(1024)
    print(str(data, "utf-8"))

s.close()
