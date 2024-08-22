.import QtQuick.LocalStorage 2.0 as LS

// Function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("MoneyManagerDB", "1.0", "Money Manager Database", 1000000);
}

// Function to initialize the database and handle migration if needed
//function initializeDatabase() {
//    var db = getDatabase();
//    db.transaction(function(tx) {
//        // Check if the new 'id' column exists
//        var rs = tx.executeSql("PRAGMA table_info(Transactions)");
//        var idExists = false;

//        for (var i = 0; i < rs.rows.length; i++) {
//            if (rs.rows.item(i).name === "id") {
//                idExists = true;
//                break;
//            }
//        }

//        // If 'id' column does not exist, create a new table with 'id' as PRIMARY KEY
//        if (!idExists) {
//            tx.executeSql('CREATE TABLE IF NOT EXISTS Transactions_new (id INTEGER AUTOINCREMENT, type TEXT, name TEXT, amount REAL, date TEXT)');

//            // Copy data from old Transactions table to new Transactions_new table
//            tx.executeSql('INSERT INTO Transactions_new (type, name, amount, date) SELECT type, name, amount, date FROM Transactions');



//            // Rename the new Transactions_new table to Transactions
//            tx.executeSql('ALTER TABLE Transactions_new RENAME TO Transactions');
//        }

//        // Insert demo data if no data exists
//        rs = tx.executeSql('SELECT COUNT(*) AS count FROM Transactions');
//        if (rs.rows.item(0).count === 0) {
//            // Insert demo data
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Coffee", 2.50, "2024-08-01"]);
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Lunch", 12.00, "2024-08-02"]);
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Bus Ticket", 3.00, "2024-08-03"]);
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Groceries", 25.00, "2024-08-04"]);
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Income", "Salary", 1500.00, "2024-08-01"]);
//            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Income", "Freelance", 300.00, "2024-08-05"]);
//        }
//    });
//}

// Function to initialize the database and insert demo data
function initializeDatabase() {
    var db = getDatabase();
    db.transaction(function(tx) {
        // Drop the old Transactions table
//        tx.executeSql('DROP TABLE IF EXISTS Transactions');
        // Create the table if it does not exist
        tx.executeSql('CREATE TABLE IF NOT EXISTS Transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, name TEXT, amount REAL, date TIMESTAMP)');

        // Check if demo data already exists
        var rs = tx.executeSql('SELECT COUNT(*) AS count FROM Transactions');
        if (rs.rows.item(0).count === 0) {
            // Insert demo data
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Coffee", 2.50, "2024-08-01 09:00:00"]);
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Lunch", 12.00, "2024-08-02 12:00:00"]);
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Bus Ticket", 3.00, "2024-08-03 08:30:00"]);
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Expense", "Groceries", 25.00, "2024-08-04 16:45:00"]);
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Income", "Salary", 1500.00, "2024-08-01 00:00:00"]);
            tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', ["Income", "Freelance", 300.00, "2024-08-05 14:00:00"]);
        }
    });
}


// Function to add a transaction
function addTransaction(type, name, amount, date) {
    var db = getDatabase();
    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Transactions (type, name, amount, date) VALUES (?, ?, ?, ?)', [type, name, amount, date]);
    });
}

// Function to fetch all transactions or filter by date
function getTransactions(date, callback) {
    var db = getDatabase();
    db.readTransaction(function(tx) {
        var rs;
        if (date === "All") {
            rs = tx.executeSql('SELECT * FROM Transactions');
        } else {
            rs = tx.executeSql('SELECT * FROM Transactions WHERE date = ?', [date]);
        }
        callback(rs.rows);
    });
}

// Function to delete a transaction by its id
function deleteTransaction(date) {
    var db = getDatabase();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Transactions WHERE date = ?', [date], function(tx, results) {
            console.log("Transaction deleted successfully.");
        }, function(tx, error) {
            console.error("Error deleting transaction: " + error.message);
        });
    });
}
