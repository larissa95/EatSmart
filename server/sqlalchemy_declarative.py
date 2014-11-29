import os
import sys
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import create_engine

Base = declarative_base()
#really useful Tutorial: http://www.pythoncentral.io/sqlalchemy-orm-examples/
#Object Relational database
#table,mapper,class

class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    name = Column(String(250), nullable=True)
    firstLogin = Column(DateTime(timezone=True),
                       primary_key=False,
                       nullable=False,
                       )
    age = Column(Integer, primary_key=True)
    meals = relationship(
        'Meal',
        secondary='meal_user_link'
    )

class HostRating(Base):
    __tablename__ = 'hostRating'
    id = Column(Integer, primary_key=True)
    quality = Column(Integer, primary_key=False)
    quantity = Column(Integer, primary_key=False)
    ambience = Column(Integer, primary_key=False)
    mood = Column(Integer, primary_key=False)
    user = relationship('User', backref=backref('hostratings', order_by=id)) 
    # => one to many relationship => one user many HostRatings
    # for a list of hostratings call user.hostratings
    # Meal und nicht 'Meal' as Meal is not defined at this moment
    meal = relationship('Meal')


class GuestRating(Base):
    __tablename__ = 'guestRating'
    id = Column(Integer, primary_key=True)
    guestRating = Column(Integer, primary_key=False)
    user = relationship('User')
    meal = relationship('Meal')

class Meal(Base):
    __tablename__ = 'meal'
    id = Column(Integer, primary_key=True)
    typ = Column(String(250), nullable=True)
    date = Column(DateTime(timezone=True),
                        primary_key=False,
                        nullable=False,
                       )
    dateRegistrationEnd = Column(DateTime(timezone=True),
                        primary_key=False,
                        nullable=False,
                       )    
    #for many to many relationship: (meal/user)
    users = relationship(
    'User',
    secondary='meal_user_link'
    )
    price = Column(Float, primary_key=False)
    address = Column(String(500), nullable=True)
    #"placeGPS": {"longitude": 48.822801, "latitude": 9.165044},
    host = relationship(User)
    #userId
    imageUrl = Column(String(250), nullable=True)


class MealUserLink(Base):
    __tablename__ = 'meal_user_link'
    #damit Kombination aus User und Meal unique ist => z.B Paar(Meal 1, User 1) soll es nur einmal geben
    meal_id = Column(Integer, ForeignKey('meal.id'), primary_key=True)
    user_id = Column(Integer, ForeignKey('user.id'), primary_key=True)



engine = create_engine('sqlite:///sqlalchemy.db')
Base.metadata.create_all(engine)

