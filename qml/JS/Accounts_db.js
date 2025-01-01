function getDatabase() {
    return LocalStorage.openDatabaseSync("MoneyManager", "1.0", "StorageDatabase", 1000000);
}

function getNumberOfTables() {
    var db = getDatabase();
    var query = "SELECT COUNT(*) AS number_of_tables FROM sqlite_master WHERE type='table'";
    var res;

    db.transaction(function (tx) {
        var rs = tx.executeSql(query);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).number_of_tables;
        }
    });
    return res || 0;
}

function getNewID() {
    var db = getDatabase();
    var newID = 1;

    db.transaction(function (tx) {
        var rs = tx.executeSql('SELECT MAX(account_id) AS max_id FROM accounts');
        if (rs.rows.length > 0 && rs.rows.item(0).max_id !== null) {
            newID = rs.rows.item(0).max_id + 1;
        }
    });
    return newID;
}

function initializeDatabase() {
    var db = getDatabase();

    db.transaction(function (tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS accounts (account_id INT PRIMARY KEY NOT NULL UNIQUE, type_id INT NOT NULL REFERENCES account_types(type_id), account TEXT NOT NULL);');

        // Insert example data for Accounts if empty
        insertAccount("Main Savings", 1);
        insertAccount("Daily Expenses", 2);
        insertAccount("Travel Card", 3);
    });
}

function getAllAccounts(accountType) {
    var db = getDatabase();
    var result = [];

    db.transaction(function (tx) {
        var rs = tx.executeSql('SELECT account_id, account FROM accounts WHERE type_id =? ORDER BY account', [accountType]);
        for (var i = 0; i < rs.rows.length; i++) {
            result.push({
                id: rs.rows.item(i).id,
                Account: rs.rows.item(i).Account,
                Account_Type_ID: rs.rows.item(i).Account_Type_ID,
            });
        }
    });
    return result;
}

function insertAccount(account, accountType) {
    var db = getDatabase();
    var result;
    var newID = getNewID();
    db.transaction(function (tx) {
        try {
            tx.executeSql('INSERT INTO accounts VALUES (?,?,?)', [newID,accountType,account]);
            result = "Account inserted successfully";
        } catch (e) {
            console.error(e);
            result = "Error: Unable to insert account";
        }
        console.log(result);
    });
    return result;
}

function resetDatabase() {
    var db = getDatabase();

    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS accounts');
    });
    initializeDatabase();
}
