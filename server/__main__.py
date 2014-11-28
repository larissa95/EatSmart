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

@app.route('/meals/<id>/user/add/<userId>', methods=['POST'])
#payment

@app.route('/meals/<id>/user/remove/<userId>', methods=['POST'])


@app.route('/meals/search/<latitude>/<longitude>', methods=['GET'])
	#pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
	#pass userId


@app.route('/rating/host/add/<uhostID>', methods=['POST'])


@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])

@app.route('/rating/guest/add/<userId>', methods=['POST'])
	#pass uhostID 

@app.route('/rating/guest/average/get/<userId>', methods=['GET'])
	#pass uhostID 

@app.route('/user/create', methods=['POST'])
def createUser():
	userId = uuserId.uuserId4()
	#create User and save it in Database
	return userId;


@app.route('/user/<userId>/delete', methods=['POST'])
def deleteUser(userId):
	pass

@app.route('/user/<userId>/get/information', methods=['GET'])
def getUserInformation():
#name, ratings
	pass

@app.route('/user/<userId>/set/information', methods=['POST'])
def createUser(**kwargs):
	name = String(request.args.get('name', 'Muster')
	#toAdd: Interface to change User Attributes after Creation
	pass

@app.route('/get/food/<latitude>/<longitude>/', methods=['GET'])
def getLocations(latitude, longitude):
	pass

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

