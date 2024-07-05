from config import db

class Contact(db.Model):
    id= db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(20), unique=False, nullable=False)
    email = db.Column(db.String(35), unique=True, nullable=False)

    def to_json(self):
        return {
            "id": self.id,
            "userName": self.username,
            "password": self.password,
            "email": self.email,
        }