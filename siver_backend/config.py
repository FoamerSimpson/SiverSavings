from flask import Flask
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_session import Session

app = Flask(__name__)
CORS(app)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///mydatabase.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
migrate= Migrate(app,db)

app.config["SESSION_TYPE"] = "sqlalchemy"  
app.config["SESSION_SQLALCHEMY"] = db      
app.config["SESSION_PERMANENT"] = False    
app.config["SESSION_USE_SIGNER"] = True
app.config["SECRET_KEY"] = "This_isnt_a_very_good_secret"

Session(app)