from flask import Flask

f = open("index.html", "r")
index = f.read()


app = Flask(__name__)

@app.route("/")
def hello():
    return index

if __name__ == "__main__":
    app.run(host='0.0.0.0')
    
    
f.close()
