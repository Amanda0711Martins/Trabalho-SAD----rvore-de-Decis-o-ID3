from flask import Flask, logging, request, jsonify
from flask_cors import CORS
from db import get_db_connection
from id3 import train_id3, predict_disease

app = Flask(__name__)
CORS(app)

logging.getLogger('flask_cors').level = logging.DEBUG

@app.route('/diagnosis', methods=['POST'])
def diagnose():
    data = request.json
    symptoms = data.get("symptoms", [])

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM training_data")
    training_data = cursor.fetchall()
    cursor.close()
    conn.close()

    diagnosis = predict_disease(training_data, symptoms)
    return jsonify({"diagnosis": diagnosis})

if __name__ == '__main__':
    app.run(debug=True)
