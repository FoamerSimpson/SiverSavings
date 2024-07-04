
#create
from flask import request, jsonify
from config import app, db
from models import Contact

@app.route('/contacts', methods=['GET'])
def get_contacts():
    contacts = Contact.query.all()
    return jsonify([contact.to_json() for contact in contacts])


@app.route('/contact', methods=['POST'])
def create_contact():
    data = request.get_json()
    new_contact = Contact(
        username=data['username'],
        password=data['password'],
        email=data['email']
    )
    db.session.add(new_contact)
    db.session.commit()
    return jsonify(new_contact.to_json()), 201

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    
    app.run(debug=True)