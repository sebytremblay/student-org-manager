from flask import jsonify
from src import db

def validate_event_type(event_type):
    """Validate that the provided event type is valid.

    Args:
        event_type (str): The event type to validate.

    Returns:
        tuple: A tuple containing the response message and status code.
    """
    # Finds all event types dynamically by finding foreign keys to event table
    cursor = db.get_db().cursor()
    query = '''
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = '{database_name}' 
            AND table_name != 'Events' 
            AND EXISTS (SELECT 1 
                        FROM information_schema.columns 
                        WHERE table_name = 'Events' 
                        AND column_name = 'eventID' 
                            AND table_name = CONCAT(column_name, 's'))
    '''.format(database_name=db.get_db().database)
    cursor.execute(query)
    
    # If query fails, return 500
    if cursor.rowcount == 0:
        return jsonify({"message": "Internal server error"}), 500
    
    # Check if the provided event type is valid
    valid_event_types = [row[0] for row in cursor.fetchall()]
    if event_type not in valid_event_types:
        return jsonify({"message": "Invalid event type"}), 400
    
    return jsonify({"message": "Event type is valid"}), 200

# Helper function to insert/update event type details
def validate_event_type_details(event_data, event_type_fields):
    """Validate event type details for insertion/updating

    Args:
        event_data (dict): The event data to validate.
        event_type_fields (dict): The fields required for each event type.

    Returns:
        _type_: _description_
    """
    event_type = event_data.get('eventType', None)
    if not validate_event_type(event_type):
        return False, f"Invalid event type: {event_type}."

    required_fields = event_type_fields.get(event_type)
    if not all(field in event_data for field in required_fields):
        return False, "Missing required fields for event type."
    
    return True, "Event type details are valid."
