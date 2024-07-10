
#create
from flask import request, jsonify
from config import app, db
from models import Contact

@app.route('/contacts', methods=['GET'])
def get_contacts():
    contacts = Contact.query.all()
    return jsonify([contact.to_json() for contact in contacts])


@app.route('/contacts/clear', methods=['DELETE'])
def clear_contacts():
    try:
        num_rows_deleted = db.session.query(Contact).delete()
        db.session.commit()
        return jsonify({'message': f'{num_rows_deleted} contacts deleted successfully.'}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


@app.route('/contact', methods=['POST'])
def create_contact():
    data = request.get_json()

    # Check if username or email already exists
    existing_username = Contact.query.filter_by(username=data['username']).first()
    existing_email = Contact.query.filter_by(email=data['email']).first()

    if existing_username:
        return jsonify({"error": "Username already exists"}), 400

    if existing_email:
        return jsonify({"error": "Email already exists"}), 400

    new_contact = Contact(
        username=data['username'],
        password=data['password'],
        email=data['email']
    )
    db.session.add(new_contact)
    db.session.commit()
    return jsonify({"message": "Account sucessfully created"}), 201

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    
    app.run(debug=True)