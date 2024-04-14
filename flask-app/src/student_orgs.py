from flask import Blueprint, request, jsonify
from src import db
from src import route_util as ru

orgs = Blueprint('orgs', __name__)

event_type_fields = {
    'Games': ['opponentTeamName', 'nuScore', 'opponentScore', 'injuriesDescription'],
    'Workshops': ['speakerEmail', 'speakerFirstName', 'speakerLastName', 'topic', 'collabOrgId'],
    'Meetings': ['agenda', 'duration'],
    'CommunityServices': ['hours', 'serviceDescription'],
    'Philanthropies': ['cause', 'amountRaised'],
    'Rituals': ['ritualName', 'ritualDescription'],
    'Practices': ['injuriesDesc'],
}

# Create StudentOrg
@orgs.route('/orgs', methods=['POST'])
def create_org():
    org_data = request.json
    cursor = db.get_db().cursor()
    query = 'INSERT INTO StudentOrgs (name, establishedAt, orgType) VALUES (%s, %s, %s)'
    data = (
        org_data['name'],
        org_data['establishedAt'],
        org_data['orgType']
    )
    cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({"message": "Organization created successfully"}), 201

# Update StudentOrg
@orgs.route('/orgs/<int:org_id>', methods=['PUT'])
def update_org(org_id):
    org_data = request.json
    cursor = db.get_db().cursor()
    query = 'UPDATE StudentOrgs SET name = %s, establishedAt = %s, orgType = %s WHERE orgID = %s'
    data = (
        org_data['name'],
        org_data['establishedAt'],
        org_data['orgType'],
        org_id
    )
    cursor.execute(query, data)
    db.get_db().commit()
    return jsonify({"message": "Organization updated successfully"}), 200

# Delete StudentOrg
@orgs.route('/orgs/<int:org_id>', methods=['DELETE'])
def delete_org(org_id):
    cursor = db.get_db().cursor()
    query = 'DELETE FROM StudentOrgs WHERE orgID = %s'
    cursor.execute(query, (org_id,))
    db.get_db().commit()
    return jsonify({"message": "Organization deleted successfully"}), 200

# Get StudentOrg
@orgs.route('/orgs/<int:org_id>', methods=['GET'])
def get_org(org_id):
    cursor = db.get_db().cursor()
    query = 'SELECT * FROM StudentOrgs WHERE orgID = %s'
    cursor.execute(query, (org_id,))
    org_data = cursor.fetchone()
    if org_data:
        return jsonify(org_data), 200
    else:
        return jsonify({"message": "Organization not found"}), 404

# Get the current executive board
@orgs.route('/orgs/<int:org_id>/executive-board', methods=['GET'])
def get_executive_board(org_id):
    cursor = db.get_db().cursor()
    query = '''
    SELECT userID, positionName FROM Roles
    WHERE orgID = %s AND positionName NOT LIKE '%%member%%'
    '''
    cursor.execute(query, (org_id,))
    board_members = cursor.fetchall()
    return jsonify(board_members), 200

# Get all upcoming events for a student organization
@orgs.route('/orgs/<int:org_id>/upcoming-events', methods=['GET'])
def get_upcoming_events(org_id):
    cursor = db.get_db().cursor()
    query = '''
    SELECT * FROM Events
    WHERE orgID = %s AND startTime > NOW()
    ORDER BY startTime ASC
    '''
    cursor.execute(query, (org_id,))
    events = cursor.fetchall()
    return jsonify(events), 200

# Get upcoming events of a specified type
@orgs.route('/orgs/<int:org_id>/upcoming-events/<event_type>', methods=['GET'])
def get_upcoming_events_by_type(org_id, event_type):
    # Validate the event type
    response = ru.validate_event_type(event_type)
    if response[1] != 200:
        return response

    # Get all upcoming events of the specified type
    cursor = db.get_db().cursor()
    query = '''
    SELECT * FROM Events
    INNER JOIN {table_name} ON Events.eventID = {table_name}.eventID
    WHERE Events.orgID = %s AND Events.startTime > NOW()
    ORDER BY Events.startTime ASC
    '''.format(table_name=event_type)
    cursor.execute(query, (org_id,))
    events = cursor.fetchall()
    return jsonify(events), 200

# Get outstanding dues for the organization
@orgs.route('/orgs/<int:org_id>/dues/outstanding', methods=['GET'])
def get_outstanding_dues(org_id):
    cursor = db.get_db().cursor()
    query = '''
    SELECT Dues.dueDate, Dues.userID, SUM(Dues.amount) AS totalDue
    FROM Dues
    WHERE orgID = %s AND beenPaid IS FALSE
    GROUP BY Dues.userID
    '''
    cursor.execute(query, (org_id,))
    dues = cursor.fetchall()
    return jsonify(dues), 200

# Create an event
@orgs.route('/events', methods=['POST'])
def create_event():
    event_data = request.json
    cursor = db.get_db().cursor()

    # Insert into Events table
    event_query = '''
    INSERT INTO Events (orgID, name, startTime, endTime, location, isMandatory)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''
    event_values = (
        event_data['orgID'],
        event_data['name'],
        event_data['startTime'],
        event_data['endTime'],
        event_data['location'],
        event_data.get('isMandatory', False)
    )
    cursor.execute(event_query, event_values)
    event_id = cursor.lastrowid

    # Validate event type and insert event type details
    is_valid = ru.validate_event_type_details(
        event_id, event_data, event_type_fields)
    if not is_valid[0]:
        return jsonify({"message": is_valid[1]}), 400

    # Prepare event type details
    required_fields = event_type_fields[event_data['eventType']]
    fields = ', '.join(required_fields)
    placeholders = ', '.join(['%s'] * len(required_fields))
    values = [event_id] + [event_data[field] for field in required_fields]

    # Insert into event type table
    cursor = db.get_db().cursor()
    query = f"INSERT INTO {event_data['eventType']} (eventID, {fields}) VALUES (%s, {placeholders})"
    cursor.execute(query, values)

    db.get_db().commit()
    return jsonify({"message": "Event created successfully"}), 201

# Update an event
@orgs.route('/events/<int:event_id>', methods=['PUT'])
def update_event(event_id):
    event_data = request.json
    cursor = db.get_db().cursor()

    # Update Events table
    event_query = '''
    UPDATE Events SET name = %s, startTime = %s, endTime = %s, location = %s, isMandatory = %s
    WHERE eventID = %s
    '''
    event_values = (
        event_data['name'],
        event_data['startTime'],
        event_data['endTime'],
        event_data['location'],
        # Default is False if not provided
        event_data.get('isMandatory', False),
        event_id
    )
    cursor.execute(event_query, event_values)

    # Validate event type and update event type details
    is_valid = ru.validate_event_type_details(
        event_id, event_data, event_type_fields)
    if not is_valid[0]:
        return jsonify({"message": is_valid[1]}), 400

    # Prepare event type details
    required_fields = event_type_fields[event_data['eventType']]
    fields_set = ', '.join(f"{field} = %s" for field in required_fields)
    values = [event_data[field] for field in required_fields]
    values.append(event_id)

    # Update event type table
    cursor = db.get_db().cursor()
    query = f"UPDATE {event_data['eventType']} SET {fields_set} WHERE eventID = %s"
    cursor.execute(query, values)

    db.get_db().commit()
    return jsonify({"message": "Event updated successfully"}), 200

# Delete an event
@orgs.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    cursor = db.get_db().cursor()
    event_query = 'DELETE FROM Events WHERE eventID = %s'
    
    # Delete from Events table will cascade to event type table
    cursor.execute(event_query, (event_id,))

    db.get_db().commit()
    return jsonify({"message": "Event deleted successfully"}), 200