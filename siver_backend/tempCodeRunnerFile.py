@app.route('/protected')    
def protected():
    if 'user_id' not in session:
        return jsonify({"error": "Unauthorized access"}), 401

    user_id = session['user_id']
    user = Contact.query.get(user_id)
    
    return jsonify({"message": f"Welcome {user.savings_goal}"}), 200