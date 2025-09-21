from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    # This will look for 'curriculo.html' inside the 'templates' folder
    return render_template('curriculo.html')

@app.route('/healthz')
def healthz():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    # Listen on all available network interfaces
    app.run(host='0.0.0.0', port=80)