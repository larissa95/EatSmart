import json
import logging
import os
import uuid
import math
from datetime import datetime
import requests
from sqlalchemy_declarative import *
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound

from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/meals/create', methods=['POST'])
def meal_create():
    name = request.form['name']
    DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

    date = datetime.strptime(request.form['date'], DATETIME_FORMAT)
    dateRegistrationEnd = datetime.strptime(request.form['dateRegistrationEnd'], DATETIME_FORMAT)
    price = request.form['price']
    host = request.form['host']
    address = request.form['address']
    typ = request.form['typ']
    session = DBSession()
    host = session.query(User).filter(User.id == host).one()
    meal = Meal(name=name,
                date=date,
                dateRegistrationEnd=dateRegistrationEnd,
                price=price,
                address=address,
                typ = typ,
                host= host)
    session.add(meal)
    session.commit()
    mealDic = {"success": True, "mealId": meal.id}
    session.close()
    return jsonify(mealDic)
    #pass user id, datum, meal name,... 


@app.route('/meals/<mealId>/delete', methods=['POST'])
def meal_delete(mealId):
    session = DBSession()
    try:
        meal= session.query(Meal).filter(Meal.id==mealId).one()
        session.delete(meal)
        session.commit()
    except NoResultFound:
        return jsonify({"success": False, "error": {"message": "No Meal Found with this id"}})
    session.close()

    return jsonify({"success": True})


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
    session = DBSession()
    try:
        meal= session.query(Meal).filter(Meal.id==mealId).one()
        host = meal.host
        responseDic = {"success": True,
                   "mealId": mealId,
                   "typ": meal.typ,
                   "date": meal.date,
                   "dateRegistrationEnd": meal.dateRegistrationEnd,
                   "price": meal.price,
                   "place": meal.address,
                   "walking_distance": 1560,
                   "placeGPS": {"latitude": 48.822801, "longitude": 9.165044},
                   "host": {"hostname": host.name, "age": host.age, "phone": host.phone, "gender": host.gender, "hostId": host.id},
                   "image": "http://placekitten.com/g/200/300"}
        session.commit()
    except NoResultFound:
        return jsonify({"success": False, "error": {"message": "No Meal Found with t id"}})
    session.close()
    
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
    resultList = [{"mealId": uuid.uuid4(), "mealName": "Sauerbraten", "walkingTime": 1560, "date": datetime.now(), "rating": 5, "price": 3.20}]
    responseDic = {"success": True, "results": resultList}
    return jsonify(responseDic)
    #pass time, typ

@app.route('/rating/host/add/<uhostID>', methods=['POST'])
def rating_host_add(uhostId):
    pass
        #pass uID => to identify if user really participated in meal
        #check if bewertung exists
    #pass userId,mealID

@app.route('/rating/host/average/get/<uhostID>', methods=['GET'])
def rating_host_average_get(uhostID):
    hostRatingDic = {"success":True}
    hostRatingDic.update(calculateAverageHostRating(uhostID))
   
    return jsonify(hostRatingDic)


@app.route('/rating/guest/add/<userId>', methods=['POST'])
def rating_guest_add(userId):
    pass
    #pass uhostID and check meals

@app.route('/rating/guest/average/get/<userId>', methods=['GET'])
def rating_guest_average_get(userId):
    guestRatingDic = {"success":True, "guestRating":calculateAverageGuestRating(userId)}
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


@app.route('/user/<userId>/information', methods=['GET'])
def getUserInformation(userId):
    hostRating = calculateAverageHostRating(userId)
    user = session.query(User).filter(User.id == userId).one()
    userDic = {"success": True,
                "userId":userId,
                #könnte auch None sein, wenn name nicht gesetzt ist
                "name":user.name,
                "firstLogin": user.firstLogin,
                "age":user.age,
                "phone":user.phone,
                "hostRating":hostRating,
                "guestRating":calculateAverageGuestRating(userId)}

    return jsonify(userDic);


@app.route('/user/<userId>/information', methods=['PUT'])
def setUserInfromation(userId):
    age = request.form['age']
    phone = request.form['phone']
    gender = request.form['gender']
    name = request.form['name']
    session = DBSession()
    try:
        user = session.query(User).filter(User.id == userId).one()
        user.age = age
        user.phone = phone
        user.name = name
        user.gender = gender
        session.add(user)
        session.commit
    except NoResultFound:
        pass
    session.close()
    return {"sucess": True}

def calculateAverageGuestRating(userId):
    session = DBSession()
    user = session.query(User).filter(User.id == userId).one()
    averageGuestRating = 0
    for guestrate in user.guestratings: 
        averageGuestRating += guestrate
    numberOfRatings = len(user.guestratings)
    session.close()
    if(numberOfRatings == 0):
        return None
    else:
        return averageGuestRating/numberOfRatings

def calculateAverageHostRating(userId):
    session = DBSession()
    user = session.query(User).filter(User.id == userId).one()
    averageQuality = 0
    averageQuantity = 0
    averageAmbience = 0
    averageMood = 0

    comments = []
    for hostrate in user.hostratings:
        averageQuality += hostrate.quality
        averageQuantity += hostrate.quantity
        averageAmbience += hostrate.ambience
        averageMood += hostrate.mood
        if hostrate.comment is not None:
            l.append(hostrate.comment)

    numberOfRatings = len(user.hostratings)
    session.close()
    if(numberOfRatings ==0):
        return None
    else:
        return{"quality":averageQuality/numberOfRatings,
                    "quantity":averageQuantity/numberOfRatings,
                    "ambience":averageAmbience/numberOfRatings,
                    "mood":averageMood/numberOfRatings,
                    "comments":comments}

if __name__ == '__main__':
    engine = create_engine('sqlite:///sqlalchemy.db')
    DBSession = sessionmaker(bind=engine)
    app.run(debug=True, host='0.0.0.0')

    #version api
