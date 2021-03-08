from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()

class Settings(Base):
    __tablename__='settings'
    id = Column(Integer, primary_key=True)
    version = Column(String(250), nullable=False)

engine = create_engine('sqlite:///commands.db')
Base.metadata.create_all(engine)
