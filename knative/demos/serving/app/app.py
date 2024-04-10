import os

from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():
    target = os.environ.get('TARGET', 'World')

    headers = {
        'ce-id': '1234567890',
        'ce-source': '/mycontext',
        'ce-specversion': '1.0',
        'ce-type': 'com.example.someevent'
    }

    return 'Hello {}!\n'.format(target)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
