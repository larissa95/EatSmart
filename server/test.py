from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import datetime
 
from sqlalchemy_declarative import *
 
engine = create_engine('sqlite:///sqlalchemy.db')
Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)
session = DBSession()
 
user1 = User(name='Minion',firstLogin=datetime.datetime.now(),age = 34)
session.add(user1)
user2 = User(name='Frede')
session.add(user2)
user3 = User(name='Fritz')
session.add(user3)


meal1 = Meal(name='test', date=datetime.datetime.now(), dateRegistrationEnd=datetime.datetime.now(),price=3.4,address='dfa', host=user1)
session.add(meal1)

meal1.users.append(user2)
meal1.users.append(user3)
meal2 = Meal(name='test1', date=datetime.datetime.now(), dateRegistrationEnd=datetime.datetime.now(),price=4.2,address='dfa', host=user1)
session.add(meal2)
user2.meals.append(meal2)
#user2 should have meal1 and 2

hostRate = HostRating(quality = 3, quantity = 4, host = user1, meal = meal1, user_id = user2.id)
session.add(hostRate)

hostRate1 = HostRating(quality = 2, quantity = 1, host = user1, meal = meal1, user_id = user3.id)
session.add(hostRate1)

session.commit()



print(user1.hostratings[1].quality);

print(user2.meals[0].name)
print(user2.meals[1].name)
print(meal1.users[0].name)
