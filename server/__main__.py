import json
import logging
import os
import uuid
import datetime
from sqlalchemy_declarative import *
from sqlalchemy.orm import sessionmaker

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


@app.route('/meals/<id>/get/information', methods=['GET'])
def meal_get_information(mealId):
    responseDic = {"success": True,
                   "mealId": mealId,
                   "typ": "food",
                   "date": datetime.datetime.now(),
                   "dateRegistrationEnd"
                   "price": 3.00,
                   "place": "Adolfstraße 27, 70469 Feuerbach",
                   "placeGPS": {"latitude": 48.822801, "longitude": 9.165044},
                   "host": "TODO",
                   "image": "url"}
    return jsonify(responseDic)
#get guests, date,...


@app.route('/meals/<id>/user/add/<uID>', methods=['POST'])
def meal_user_add(userId):
    responseDic = {"success": True, "mealId": userId}
    return jsonify(responseDic)

@app.route('/meals/<id>/user/remove/<uID>', methods=['POST'])
def meal_user_remove(userId):
    responseDic = {"success": True, "mealId": userId}
    return jsonify(responseDic)

@app.route('/meals/search/<latitude>/<longitude>', methods=['GET'])
def meal_search(latitude, longitude):
    responseDic = {"success": True, "mealId": userId}
    return jsonify(responseDic)
    #pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
def rating_host_add(uhostId):
    pass
    #pass uID

@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])
def rating_host_average_get(uhostID):
    #pass uID => to identify if user really participated in meal
    hostRatingDic = {"success":True,
                    "quality":2.3,
                    "quantity":2.1,
                    "ambience":2.3,
                    "mood":5}
    return jsonify(hostRatingDic)


@app.route('/rating/guest/add/<uID>', methods=['POST'])
def rating_guest_add(uID):
    pass
    #pass uhostID 

@app.route('/rating/guest/average/get/<uID>', methods=['GET'])
def rating_guest_average_get(uID):
    #pass uhostID 
    guestRating = 3.4
    guestRatingDic = {"success":True, "guestRating":guestRating}
    return jsonify(guestRatingDic)

@app.route('/user/create', methods=['POST'])
def createUser():
    new_user = User()
    session = DBSession()
    session.add(new_user)
    session.commit()
    userDic = {"success": True, "userId":new_user.id}
    session.close()
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
    engine = create_engine('sqlite:///sqlalchemy.db')
    DBSession = sessionmaker(bind=engine)
    app.run(debug=True, host='0.0.0.0')

    #version api

