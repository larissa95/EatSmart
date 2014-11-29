from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from datetime import datetime
 
from sqlalchemy_declarative import *
 
engine = create_engine('sqlite:///sqlalchemy.db')
Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)
session = DBSession()
 
user1 = User(name='Minion',age = 34,phone="49157312341234",gender="male",imageUrl="http://placekitten.com/g/200/300")
session.add(user1)
user2 = User(name='Frede',age = 19,phone="49157312341234",gender="female",imageUrl="http://placekitten.com/g/200/300")
session.add(user2)
user3 = User(name='Fritz',age = 20,phone="49157312341234",gender="male",imageUrl="http://placekitten.com/g/200/300")
session.add(user3)


meal1 = Meal(name='Pasta',
             typ="cooking",
             date=datetime.now(),
             dateRegistrationEnd=datetime.now(),
             price=3.4,
             latitude=48.737520,
             longitude=9.101677,
             address='Am Feldweg 39, Stuttgart',
             host=user1,
             maxGuests=5
             )
session.add(meal1)

meal1.users.append(user2)
meal1.users.append(user3)

meal2 = Meal(name='Sushi',
             typ="food",
             date=datetime.now(),
             dateRegistrationEnd=datetime.now(),
             price=3.4,
             latitude=48.737520,
             longitude=9.101677,
             address='Am Feldweg 2, Stuttgart',
             host=user2,
             maxGuests=2)
session.add(meal2)
meal2.users.append(user1)
meal2.users.append(user3)

hostRate = HostRating(quality = 3, quantity = 4, host = user1, meal = meal1, user_id = user2.id)
session.add(hostRate)

hostRate1 = HostRating(quality = 2, quantity = 1, host = user1, meal = meal1, user_id = user3.id)
session.add(hostRate1)

guestRate = GuestRating(guestRating = 5, user = user2, meal = meal1, host_id = user1.id)
session.add(guestRate)
guestRate = GuestRating(guestRating = 1, user = user2, meal = meal2, host_id = user1.id)
session.add(guestRate)
guestRate = GuestRating(guestRating = 2, user = user2, meal = meal1, host_id = user1.id)
session.add(guestRate)


session.commit()



print(user1.hostratings[1].quality);
print(user2.guestratings[0].guestRating);
print(user2.meals[0].name)

print(meal1.users[0].name)
