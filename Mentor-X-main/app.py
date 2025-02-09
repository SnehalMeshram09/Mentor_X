from flask import Flask, jsonify, request
import mysql.connector
from google.cloud import dialogflow_v2 as dialogflow
import os
from flask_cors import CORS
import calendar

app = Flask(__name__)
CORS(app)

# Database connection settings
DB_CONFIG = {
    "host": "localhost",
    "user": "root",  # Replace with your MySQL username
    "password": "Siddhi#19",  # Replace with your MySQL password
    "database": "mentorx",  # Replace with your database name
}

def get_db_connection():
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except mysql.connector.Error as err:
        print(f"Database connection error: {err}")
        raise

# Chatbot route
@app.route('/chatbot', methods=['POST'])
def chatbot():
    """
    Handles chat messages from the frontend and processes them via Dialogflow.
    """
    try:
        data = request.get_json()
        user_message = data.get('message')

        # Set up Dialogflow client
        session_client, session = get_dialogflow_client()
        text_input = dialogflow.TextInput(text=user_message, language_code='en')
        query_input = dialogflow.QueryInput(text=text_input)

        # Send user message to Dialogflow
        response = session_client.detect_intent(request={"session": session, "query_input": query_input})
        bot_response = response.query_result.fulfillment_text

        return jsonify({"response": bot_response})

    except Exception as e:
        print(f"Error in /chatbot route: {e}")
        return jsonify({"response": "An error occurred. Please try again later."}), 500

# Signup route
@app.route('/signup', methods=['POST'])
def signup():
    cursor = None
    conn = None
    try:
        data = request.get_json()

        # Extract fields from the request
        name = data.get('name')
        phone_no = data.get('phone_no')
        college_name = data.get('college_name')
        city = data.get('city')
        skills = data.get('skills')
        password = data.get('password_hash')  # Store original password
        email = data.get('email')
        github_id = data.get('github_id')
        linkedin_id = data.get('linkedin_id')

        if not all([name, phone_no, college_name, city, skills, password]):
            return jsonify({"error": "All fields except GitHub and LinkedIn are required."}), 400

        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        cursor.execute("SELECT phone_no FROM users WHERE phone_no = %s", (phone_no,))
        existing_user = cursor.fetchone()
        if existing_user:
            return jsonify({"error": "Phone number already registered."}), 400

        query = """
            INSERT INTO users (name, phone_no, college_name, city, skills, password_hash, email, github_id, linkedin_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (name, phone_no, college_name, city, skills, password, email, github_id, linkedin_id))
        conn.commit()

        return jsonify({"message": "User signed up successfully!"}), 201

    except mysql.connector.Error as err:
        return jsonify({"error": f"MySQL Error: {str(err)}"}), 500
    except Exception as e:
        return jsonify({"error": f"Unexpected error: {str(e)}"}), 500
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# Login route
@app.route('/log', methods=['POST'])
def log():
    try:
        data = request.get_json()
        phone_no = data.get('phone_no')
        password = data.get('password_hash')  # Store plain password from frontend

        if not phone_no or not password:
            return jsonify({"message": "Phone number and password are required!"}), 400

        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor(dictionary=True)

        query = "SELECT password_hash FROM users WHERE phone_no = %s"
        cursor.execute(query, (phone_no,))
        user = cursor.fetchone()

        if user:
            stored_password = user['password_hash']
            if stored_password == password:
                response = {"message": "Login successful!"}
            else:
                response = {"message": "Invalid password. Please try again."}, 401
        else:
            response = {"message": "Phone number not registered."}, 404

        cursor.close()
        conn.close()

    except mysql.connector.Error as err:
        response = {"message": f"MySQL Error: {str(err)}"}, 500
    except Exception as e:
        response = {"message": f"An error occurred: {str(e)}"}, 500

    return jsonify(response)

# dialogflow integration
def get_dialogflow_client():
    project_id = 'hackathonx-owxi'  # Replace with your project ID
    session_client = dialogflow.SessionsClient()
    session = session_client.session_path(project_id, 'unique-session-id')
    return session_client, session

@app.route('/webhook', methods=['POST'])
def webhook():
    req = request.get_json()
    intent = req.get('queryResult', {}).get('intent', {}).get('displayName')

    if intent == 'get_hackathon_by_theme':
        return get_hackathon_by_theme(req)
    else:
        return jsonify({"fulfillmentText": "Intent not recognized or not implemented."})

def get_hackathon_by_theme_logic(theme):
    if not theme:
        return {"error": "No theme provided."}, False

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT 
            title, dates, prize, participants, location, categories 
        FROM 
            hackathons 
        WHERE 
            LOWER(categories) LIKE %s
        """
        cursor.execute(query, (f"%{theme}%",))
        hackathons = cursor.fetchall()
        conn.close()

        if not hackathons:
            return {"message": f"No hackathons found for the theme '{theme}'."}, False

        response = []
        for hackathon in hackathons:
            response.append({
                "title": hackathon[0],
                "dates": hackathon[1],
                "prize": hackathon[2],
                "participants": hackathon[3],
                "location": hackathon[4],
                "categories": hackathon[5]
            })
        return response, True
    except Exception as e:
        return {"error": str(e)}, False

@app.route('/get_hackathon_by_theme', methods=['GET', 'POST'])
def get_hackathon_by_theme(req=None):
    try:
        if request.method == 'GET':
            theme = request.args.get('theme', '').lower()
        elif request.method == 'POST':
            req = request.get_json()
            parameters = req.get('queryResult', {}).get('parameters', {})
            theme = parameters.get('theme', '').lower()

        if not theme:
            return jsonify({"fulfillmentText": "I didn't understand the theme. Could you please specify it again."})

        results, success = get_hackathon_by_theme_logic(theme)
        if not success:
            return jsonify({"fulfillmentText": results.get("message", "An error occurred.")})

        response_text = f"Here are some hackathons related to '{theme}':\n\n"
        for i, hackathon in enumerate(results, 1):
            response_text += (
                f"{i}. {hackathon['title']}\n"
                f"📅 *Dates:* {hackathon['dates']}\n"
                f"🏆 *Prize:* {hackathon['prize']}\n"
                f"👥 *Participants:* {hackathon['participants']}\n"
                f"📍 *Location:* {hackathon['location']}\n\n"
            )

        if request.method == 'POST':
            return jsonify({"fulfillmentText": response_text})

        return jsonify({"theme": theme, "hackathons": results})
    
    except Exception as e:
        return jsonify({"fulfillmentText": "An unexpected error occurred. Please try again."})

@app.route('/get_hackathons', methods=['GET'])
def get_hackathons():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT title, dates, prize, participants, location, categories FROM hackathons"
        cursor.execute(query)
        hackathons = cursor.fetchall()

        conn.close()

        if not hackathons:
            return jsonify({"message": "No hackathons available. Please scrape first."}), 404

        response = []
        for hackathon in hackathons:
            response.append({
                "title": hackathon[0],
                "dates": hackathon[1],
                "prize": hackathon[2],
                "participants": hackathon[3],
                "location": hackathon[4],
                "categories": hackathon[5]
            })

        return jsonify({"hackathons": response}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
