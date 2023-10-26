#!/usr/bin/env python
import socket
import argparse
from pathlib import Path


def handle_conn(conn, dir):
    print("Sending verilog")

    with conn.makefile('w') as data:
        for file in dir.iterdir():
            if file.suffix == ".v":
                data.write(f'VERILOGFILE {file.name}\n')
                data.write(file.open('r').read())
                data.write('\n')

        data.write("ENDWRITE\n")

    print("Reading compiler output")
    while True:
        data = conn.recv(1024)
        with conn.makefile('r') as response:
            while line := response.readline():
                if 'COMMAND END' in line:
                    return
                else:
                    print(line, end='')


def main(host, port, dir):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        try:
            handle_conn(s, dir)
        finally:
            s.close()
        print("Done")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='Verilog TCP Sender')

    parser.add_argument('host')
    parser.add_argument('port', type=int)
    parser.add_argument('dir', type=Path)

    args = parser.parse_args()

    main(args.host, args.port, args.dir)