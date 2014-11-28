import json
import logging
import os

from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/meals/create', methods=['POST'])
	#pass user id, datum, meal name,... 



@app.route('/meals/<id>/delete', methods=['POST'])



@app.route('/meals/<id>/get/information', methods=['GET'])
#get guests, date,...

@app.route('/meals/<id>/user/add/<uID>', methods=['POST'])


@app.route('/meals/<id>/user/remove/<uID>', methods=['POST'])


@app.route('/meals/search/<latitude>/<longitude>', methods=['GET'])
	#pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
	#pass uID


@app.route('/rating/host/add/<uhostID>', methods=['POST'])


@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])

@app.route('/rating/guest/add/<uID>', methods=['POST'])
	#pass uhostID 

@app.route('/rating/guest/average/get/<uID>', methods=['GET'])
	#pass uhostID 

@app.route('/user/create', methods=['POST'])

@app.route('/user/<uID>/delete', methods=['POST'])

@app.route('/user/<uID>/get/information', methods=['GET'])
	#name, ratings

#toAdd: Interface to change User Attributes after Creation

@app.route('/get/food/<latitude>/<longitude>/', methods=['GET'])
def getLocations(latitude, longitude):
    pass

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

