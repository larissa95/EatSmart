import json
import logging
import os
import uuid
import datetime, math
import requests
from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/meals/create', methods=['POST'])
def meal_create():
    mealId = uuid.uuid4()
    mealDic = {"success": True, "mealId": mealId}
    return jsonify(mealDic)
    #pass user id, datum, meal name,... 


@app.route('/meals/<id>/delete', methods=['POST'])
def meal_delete(id):

    mealDic = {"success": True, "mealId": mealId}
    return jsonify(mealDic)


def getCloseByCoordinats(latitude, longitude, radius):
    try:
        latitude = float(latitude)
        longitude = float(longitude)
    except ValueError:
        pass  # DO MAGIC
    constLatitude = 110574  # meters of a 1 degree latitude
    constLongtitude = 111320
    latitude = latitude-radius/constLatitude
    longitude = longitude-radius/(constLongtitude*math.cos(math.radians(longitude)))
    return latitude, longitude

def getWalkingDistanceFromGoogle(startCoordinats, listofDestinations):
    origins = startCoordinats[0]+","+startCoordinats[1]
    destinations = "|".join(listofDestinations).replace(" ", "+")
    googleMapsApiUrl = "http://maps.googleapis.com/maps/api/distancematrix/json?origins={0}&destinations={1}&mode=walking".format(origins,destinations)
    return requests.get(googleMapsApiUrl).json()

@app.route('/meals/<mealId>/get/information', methods=['GET'])
def meal_get_information(mealId):
    responseDic = {"success": True,
                   "mealId": mealId,
                   "typ": "food",
                   "date": datetime.datetime.now(),
                   "dateRegistrationEnd"
                   "price": 3.00,
                   "place": "Adolfstraße 27, 70469 Feuerbach",
                   "walking_distance": getWalkingDistance(),
                   "placeGPS": {"latitude": 48.822801, "longitude": 9.165044},
                   "host": {"hostname": "Jon", "gender": "male", "hostId": 1234},
                   "image": "http://placekitten.com/g/200/300"}
    return jsonify(responseDic)
#get guests, date,...


@app.route('/meals/<mealId>/user/add/<userId>', methods=['POST'])
def meal_user_add(mealId, userId):
    responseDic = {"success": True, "mealId": userId}
    return jsonify(responseDic)

@app.route('/meals/<mealId>/user/remove/<userId>', methods=['POST'])
def meal_user_remove(mealId, userId):
    responseDic = {"success": True, "mealId": userId}
    return jsonify(responseDic)

@app.route('/meals/search/<latitude>/<longitude>', methods=['GET'])
def meal_search(latitude, longitude):
    squareLat, squareLong = getCloseByCoordinats(latitude, longitude, 5000)
    #return jsonify(getWalkingDistanceFromGoogle((latitude, longitude),["Adolfstraße 27, Feuerbach"]))
    resultList = [{"mealId": uuid.uuid4(), "mealName": "Sauerbraten", "walkingTime": 1560, "date": datetime.datetime.now(), "rating": 5, "price": 3.20}]
    responseDic = {"success": True, "results": resultList}
    return jsonify(responseDic)
    #pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
def rating_host_add(uhostId):
    pass
    #pass userId

@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])
def rating_host_average_get(uhostID):
	#pass uID => to identify if user really participated in meal
    hostRatingDic = {"success":True,
    				"quality":2.3,
					"quantity":2.1,
					"ambience":2.3,
					"mood":5}
	return jsonify(hostRatingDic)


@app.route('/rating/guest/add/<userId>', methods=['POST'])
def rating_guest_add(userId):
    pass
    #pass uhostID 

@app.route('/rating/guest/average/get/<userId>', methods=['GET'])
def rating_guest_average_get(userId):
    #pass uhostID 
    guestRating = 3.4
    guestRatingDic = {"success":True, "guestRating":guestRating}
    return jsonify(guestRatingDic)

@app.route('/user/create', methods=['POST'])
def createUser():
	userId = uuserId.uuserId4()
	#create User and save it in Database
	userDic = {"success": True, "userId":userId}
	return jsonify(userDic)


@app.route('/user/<userId>/delete', methods=['POST'])
def deleteUser(userId):
    #deleteUserFromDataBase
    pass

@app.route('/user/<userId>/get/information', methods=['GET'])
def getUserInformation():
    hostRating = {"quality":2.3,
                    "quantity":2.1,
                    "ambience":2.3,
                    "mood":5}


    userDic = {"success": True,
                "userId":userId,
                "name":"Mustermann",
                "firstLogin": datetime.datetime.now(),
                "age":38,
                "hostRating":hostRating,
                "guestRating":4}

    return jsonify(userDic);


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
    #version api

