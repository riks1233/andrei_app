#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse
import json

HOST = 'localhost'
PORT = 8000


class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(json.dumps([
            {
                "id": 210,
                "userId": "123",
                "projectId": "1",
                "info": "null",
                "registeredAt": "2020-06-02T23:01:28.0000000+00:00",
                "eventType": "START",
            },
            {
                "id": 211,
                "userId": "321",
                "projectId": "1",
                "info": "text",
                "registeredAt": "2020-06-03T00:02:38.0000000+00:00",
                "eventType": "PAUSE"
            },
            {
                 "id": 212,
                 "userId": "321",
                 "projectId": "1",
                 "info": "text",
                 "registeredAt": "2020-06-03T00:02:48.0000000+00:00",
                 "eventType": "RESUME"
            },
            {
                "id": 213,
                "userId": "321",
                "projectId": "1",
                "info": "text",
                "registeredAt": "2020-06-03T00:02:58.0000000+00:00",
                "eventType": "PAUSE"
            }
        ]).encode())
        return

    def do_POST(self):
        content_len = int(self.headers.getheader('content-length'))
        post_body = self.rfile.read(content_len)
        data = json.loads(post_body)

        parsed_path = urlparse(self.path)
        self.send_response(200)
        self.end_headers()
        self.wfile.write(json.dumps([
            {
                "id": 210,
                "userId": "123",
                "projectId": "1",
                "info": "null",
                "registeredAt": "2020-06-02T23:01:28.0000000+00:00",
                "eventType": "START",
            },
            {
                "id": 211,
                "userId": "321",
                "projectId": "1",
                "info": "text",
                "registeredAt": "2020-06-03T00:02:36.0000000+00:00",
                "eventType": "PAUSE",

            }
        ]).encode())
        return


if __name__ == '__main__':
    server = HTTPServer((HOST, PORT), RequestHandler)
    print(f"Now listening on: http://{HOST}:{PORT}")
    server.serve_forever()
