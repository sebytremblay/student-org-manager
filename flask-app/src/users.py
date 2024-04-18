from flask import Blueprint, request, jsonify
from src import db

users = Blueprint('users', __name__)

# Create User
@users.route('/users', methods=['POST'])
def create_user():
    user_data = request.json
    cursor = db.get_db().cursor()
    query = 'INSERT INTO Users (NUID, graduationYear, startDate, currentYear, firstName, lastName, goalsWants, challenges) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
    data = (
        user_data['NUID'],
        user_data['graduationYear'],
        user_data['startDate'],
        user_data['currentYear'],
        user_data['firstName'],
        user_data['lastName'],
        user_data['goalsWants'],
        user_data['challenges']
    )
    cursor.execute(query, data)
    db.get_db().commit()
    return 'User created successfully'

# Get User
@users.route('/users/<userID>', methods=['GET'])
def get_user(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Users WHERE userID = %s', (userID,))
    user_data = cursor.fetchone()
    if not user_data:
        return 'User not found', 404
    user_dict = {
        'userID': user_data[0],
        'NUID': user_data[1],
        'graduationYear': user_data[2],
        'startDate': user_data[3],
        'currentYear': user_data[4],
        'firstName': user_data[5],
        'lastName': user_data[6],
        'goalsWants': user_data[7],
        'challenges': user_data[8]
    }
    return jsonify(user_dict)

# Update User
@users.route('/users/<userID>', methods=['PUT'])
def update_user(userID):
    user_data = request.json
    cursor = db.get_db().cursor()
    query = 'UPDATE Users SET NUID = %s, graduationYear = %s, startDate = %s, currentYear = %s, firstName = %s, lastName = %s, goalsWants = %s, challenges = %s WHERE userID = %s'
    data = (
        user_data['NUID'],
        user_data['graduationYear'],
        user_data['startDate'],
        user_data['currentYear'],
        user_data['firstName'],
        user_data['lastName'],
        user_data['goalsWants'],
        user_data['challenges'],
        userID
    )
    cursor.execute(query, data)
    db.get_db().commit()
    return 'User updated successfully'

# Delete User
@users.route('/users/<userID>', methods=['DELETE'])
def delete_user(userID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Users WHERE userID = %s', (userID,))
    db.get_db().commit()
    return 'User deleted successfully'

# Get Orgs user belongs to
@users.route('/users/<userID>/orgs', methods=['GET'])
def get_user_orgs(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT orgID, name FROM StudentOrgs WHERE orgID IN (SELECT orgID FROM Roles WHERE userID = %s)', (userID,))
    orgs_data = cursor.fetchall()
    orgs_list = [{'orgID': org[0], 'name': org[1]} for org in orgs_data]
    return jsonify(orgs_list)

# Get outstanding dues for user
@users.route('/users/<userID>/dues', methods=['GET'])
def get_user_dues(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT amount, dueDate FROM Dues WHERE userID = %s', (userID,))
    dues_data = cursor.fetchall()
    dues_list = [{'amount': due[0], 'dueDate': due[1]} for due in dues_data]
    return jsonify(dues_list)

# Get schedule based on what organizations they belong to
@users.route('/users/<userID>/schedule', methods=['GET'])
def get_user_schedule(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Events WHERE orgID IN (SELECT orgID FROM Roles WHERE userID = %s)', (userID,))
    events_data = cursor.fetchall()
    events_list = [{
        'eventID': event[0],
        'orgID': event[1],
        'name': event[2],
        'startTime': event[3],
        'endTime': event[4],
        'location': event[5],
        'isMandatory': event[6]
    } for event in events_data]
    return jsonify(events_list)

# Add user to student organization
@users.route('/users/<userID>/orgs/<orgID>', methods=['PUT'])
def add_user_to_org(userID, orgID):
    cursor = db.get_db().cursor()
    query = 'INSERT INTO Roles (userID, orgID) VALUES (%s, %s)'
    data = (userID, orgID)
    cursor.execute(query, data)
    db.get_db().commit()
    return 'User added to organization successfully'

# Remove user from student organization
@users.route('/users/<userID>/orgs/<orgID>', methods=['DELETE'])
def remove_user_from_org(userID, orgID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Roles WHERE userID = %s AND orgID = %s', (userID, orgID))
    db.get_db().commit()
    return 'User removed from organization successfully'