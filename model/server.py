from http.server import HTTPServer, BaseHTTPRequestHandler

HOST = "0.0.0.0"
PORT = 9950

handles = {}

class NeuralHTTP(BaseHTTPRequestHandler):
    def do_GET(self):
        for header in self.headers:
            handles[header] = self.headers[header]
        
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()  # Remove the "Connection" header or set it explicitly to "close"
        self.wfile.write(bytes("OK\n", "utf-8"))

if __name__ == '__main__':
    server = HTTPServer((HOST, PORT), NeuralHTTP)
    server.serve_forever()
    server.server_close()
