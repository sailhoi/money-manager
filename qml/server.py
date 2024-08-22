from flask import Flask, jsonify, request
import database

app = Flask(__name__)

@app.route('/transactions', methods=['GET'])
def get_transactions():
    date = request.args.get('date', 'All')
    transactions = database.get_transactions(date)
    return jsonify([dict(row) for row in transactions])

@app.route('/delete_transaction', methods=['POST'])
def delete_transaction():
    data = request.json
    transaction_id = data.get('id')
    database.delete_transaction(transaction_id)
    return jsonify({"status": "success"})

if __name__ == "__main__":
    app.run(debug=True)
