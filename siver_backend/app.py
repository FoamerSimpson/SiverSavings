from flask_session import Session
from flask import request, jsonify, session
from flask_migrate import Migrate
from config import app, db
from models import Contact
from werkzeug.security import check_password_hash, generate_password_hash

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

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    if not username or not password:
        return jsonify({"error": "Username and password are required"}), 400
    user = Contact.query.filter_by(username=username).first()

    if user and check_password_hash(user._password_hash, password):
        session['user_id'] = user.id
        session['username'] = user.username
        return jsonify({"message": f"Login successful, Welcome {user.username}" }), 200
    else:
        return jsonify({"error": "Invalid username or password"}), 400
    

@app.route('/update_savings', methods=['POST'])
def savingsUpdate():
    if 'user_id' not in session:
        return jsonify({"message": "Log in required"}), 401
    data = request.get_json()
    if not data or 'savings' not in data:
        return jsonify({"message": "Invalid input"}), 400

    new_savings = data['savings']
    
    try:
        new_savings = float(new_savings)
    except ValueError:
        return jsonify({"message": "Savings must be a number"}), 400

    user_id = session['user_id']
    user = Contact.query.get(user_id)

    if user is None:
        return jsonify({"message": "User not found"}), 404

    user.savings_goal = new_savings
    db.session.commit()

    return jsonify({"message": "Savings updated successfully"}), 200

@app.route('/protected')    
def protected():
    if 'user_id' not in session:
        return jsonify({"error": "Login required"}), 401

    user_id = session['user_id']
    user = Contact.query.get(user_id)
    
    return jsonify({"message": f"{user.savings_goal}"}), 200


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    
    app.run(debug=True)