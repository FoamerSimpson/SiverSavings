from config import db
from werkzeug.security import generate_password_hash, check_password_hash

class Contact(db.Model):
    id= db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    _password_hash = db.Column(db.String(128), unique=False, nullable=False)
    email = db.Column(db.String(35), unique=True, nullable=False)

    @property
    def password(self):
        raise AttributeError('password is not readable')
    
    @password.setter
    def password(self, password):
        self._password_hash= generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self._password_hash, password)


    def to_json(self):
        return {
            "id": self.id,
            "userName": self.username,
            "password": self._password_hash,
            "email": self.email,
        }