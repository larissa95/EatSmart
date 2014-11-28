import json
import logging
import os
import uuid
 
from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/meals/create', methods=['POST'])
def meal_create():
    mealId = uuid.uuid4()
    meal = {"success":"1", "mealId":mealId}
    return jsonify(meal)
    #pass user id, datum, meal name,... 



@app.route('/meals/<id>/delete', methods=['POST'])
def meal_delete(id):
    pass


@app.route('/meals/<id>/get/information', methods=['GET'])
def meal_get_information():
    pass
#get guests, date,...

@app.route('/meals/<id>/user/add/<uID>', methods=['POST'])
def meal_user_add(userId):
    pass

@app.route('/meals/<id>/user/remove/<uID>', methods=['POST'])
def meal_user_remove(userId):
    pass

@app.route('/meals/search/<latitude>/<longitude>', methods=['GET'])
def meal_search(latitude, longitude):
    pass
    #pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
def rating_host_add(uhostId):
    pass
    #pass uID

@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])
def rating_host_average_get(uhostID):
    pass

@app.route('/rating/guest/add/<uID>', methods=['POST'])
def rating_guest_add(uID):
    pass
    #pass uhostID 

@app.route('/rating/guest/average/get/<uID>', methods=['GET'])
def rating_guest_average_get(uID):
    pass
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

