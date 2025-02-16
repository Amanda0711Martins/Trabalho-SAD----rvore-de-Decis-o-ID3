from flask import Flask, request, jsonify
from flask_cors import CORS
from db import get_db_connection
from id3 import train_id3
from id3 import train_id3, predict

app = Flask(__name__)
CORS(app)

# Rota para diagnóstico
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

    if not training_data:
        return jsonify({"error": "Nenhum dado de treinamento disponível"}), 500

    tree = train_id3(training_data)
    diagnosis = predict(tree, symptoms)

    return jsonify({"diagnosis": diagnosis})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
