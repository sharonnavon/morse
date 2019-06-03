#!/usr/bin/env python3

import socket

host_addr = ''           # Accept connections from any host
listen_port = 9999
morse_code_dict = {'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.', 'G': '--.', 'H': '....',
                   'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---', 'P': '.--.',
                   'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
                   'Y': '-.--', 'Z': '--..', '1': '.----', '2': '..---', '3': '...--', '4': '....-', '5': '.....',
                   '6': '-....', '7': '--...', '8': '---..', '9': '----.', '0': '-----', ', ': '--..--', '.': '.-.-.-',
                   '?': '..--..', '/': '-..-.', '-': '-....-', '(': '-.--.', ')': '-.--.-'}


def encrypt_to_morse_code(message):
    cipher = ''
    for letter in message:
        if letter != ' ':

            # Looks up the dictionary and adds the corresponding morse code
            # along with a space to separate morse codes for different characters
            cipher += morse_code_dict[letter] + ' '

        else:
            # 1 space indicates different characters and 2 indicates different words
            cipher += ' '

    return cipher


def socket_create(host, port):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)   # Create a TCP/IP socket
    s.bind((host, port))
    s.listen(5)     # Listen up to 5 bad connections before refusing to any new incoming connection

    # Wait for an incoming connection, send/receive data and close it
    while True:
        connection, client_address = s.accept()     # Get the client socket objects (connection, client_address)
        print('Connected by', client_address)
        client_address_morsed = encrypt_to_morse_code(client_address[0])

        try:
            connection.send(str.encode(client_address_morsed))
            print('Sent:', client_address_morsed)

            while True:
                data = connection.recv(1024)      # Receive data from the client in a 1024 bytes buffer

                if not data:
                    break

        except InterruptedError as err:
            print('The connection has been interrupted: ', err)

        finally:
            connection.close()


def main():
    socket_create(host_addr, listen_port)


if __name__ == '__main__':
    main()
