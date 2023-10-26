#!/usr/bin/env python
import re
import time
import socket
import tempfile
import subprocess
from pathlib import Path


def main():
    print(f'Starting server')
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.bind(('0.0.0.0', 8760))
        sock.listen()

        while True:
            print(f'Waiting for connection')
            try:
                conn, addr = sock.accept()
            except KeyboardInterrupt:
                print('Closing the server')
                return

            try:
                print(f'Connection from {addr}')
                handle_conn(conn)
            except KeyboardInterrupt:
                print('Aborting connection and closing the server')
                return
            finally:
                print(f'Closing connection from {addr}')
                conn.close()


def handle_conn(conn):
    with conn.makefile('r') as request:
        with tempfile.TemporaryDirectory() as tmpdirname:
            tmpdir = Path(tmpdirname)
            currentfile = None

            print('Receiving files')
            while line := request.readline():
                if line.startswith('VERILOGFILE'):
                    if currentfile is not None:
                        currentfile.close()
                    filename = line.split()[1]
                    currentfile = (tmpdir / filename).open('w')
                elif line.startswith('ENDWRITE'):
                    break
                elif currentfile is not None:
                    currentfile.write(line)
                else:
                    conn.sendall(b'Illegal message format: No file header')
                    return

            if currentfile is not None:
                currentfile.close()

            print('Running the program')
            with conn.makefile('w') as out:
                subprocess.run(['sh', 'compile-and-flash.sh', tmpdir], stdout=out, stderr=subprocess.STDOUT)
                out.write('COMMAND END')

    #conn.sendall(b'COMMAND END')


if __name__ == '__main__':
    main()
