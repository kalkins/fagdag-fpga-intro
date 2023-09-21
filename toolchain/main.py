#!/usr/bin/env python
import socket


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect(("0.0.0.0", "8760"))

    sock.recv()


if __name__ == "__main__":
    main()
