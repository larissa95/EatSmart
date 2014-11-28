import json
import logging
import os

from flask import Flask, jsonify, request, render_template
app = Flask(__name__)

@app.route('/get/food/<latitude>/<longitude>/', methods=['GET'])
def getLocations(latitude, longitude):
    

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

