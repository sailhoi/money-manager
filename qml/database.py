import sqlite3
from flask import Flask, jsonify, request

# Database configuration
DB_FILE = "moneymanager.db"

app = Flask(__name__)

def get_database():
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row
    return conn

def initialize_database():
    conn = get_database()
    cursor = conn.cursor()

    # Create AccountType table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS AccountType (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
        )
    ''')

    # Create Transactions table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            name TEXT,
            amount REAL,
            date TEXT,
            accountTypeId INTEGER,
            FOREIGN KEY(accountTypeId) REFERENCES AccountType(id)
        )
    ''')

    # Insert initial data if necessary
    cursor.execute('SELECT COUNT(*) FROM AccountType')
    if cursor.fetchone()[0] == 0:
        cursor.execute('INSERT INTO AccountType(name) VALUES (?)', ("Cash",))
        cursor.execute('INSERT INTO AccountType(name) VALUES (?)', ("Bank",))
        cursor.execute('INSERT INTO AccountType(name) VALUES (?)', ("Credit Card",))

    conn.commit()
    conn.close()

@app.route('/get_transactions', methods=['GET'])
def get_transactions():
    date = request.args.get('date', 'All')
    transaction_type = request.args.get('type', 'All')
    sort_order = request.args.get('sort', 'Date')

    query = '''
        SELECT Transactions.*, AccountType.name as accountTypeName
        FROM Transactions
        LEFT JOIN AccountType ON Transactions.accountTypeId = AccountType.id
        WHERE (? = 'All' OR date = ?)
        AND (? = 'All' OR type = ?)
    '''

    if sort_order == "Date":
        query += " ORDER BY date"
    elif sort_order == "Amount":
        query += " ORDER BY amount"

    conn = get_database()
    cursor = conn.cursor()
    cursor.execute(query, (date, date, transaction_type, transaction_type))
    rows = cursor.fetchall()
    conn.close()

    return jsonify([dict(row) for row in rows])

@app.route('/delete_transaction', methods=['POST'])
def delete_transaction():
    transaction_id = request.json['id']
    conn = get_database()
    cursor = conn.cursor()
    cursor.execute('DELETE FROM Transactions WHERE id = ?', (transaction_id,))
    conn.commit()
    conn.close()

    return jsonify({"status": "success"})

if __name__ == "__main__":
    initialize_database()
    app.run(debug=True)
