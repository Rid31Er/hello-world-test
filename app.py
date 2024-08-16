from flask import Flask
from waitress import serve
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!m"

if __name__ == "__main__":
    print("Serving application at port 3000")
    serve(app, host='0.0.0.0', port=3000, threads=4)
