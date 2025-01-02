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
        tx.executeSql('CREATE TABLE IF NOT EXISTS accounts (account_id INTEGER PRIMARY KEY NOT NULL UNIQUE, type_id INT NOT NULL REFERENCES account_types(type_id), account TEXT NOT NULL);');
    });
}

function getAllAccounts(accountType) {
    var db = getDatabase();
    var res = {}; // Object to store accounts with account_id as key
    console.log("Account Type:", accountType); // Log the passed accountType

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT account_id, account FROM accounts WHERE type_id = ? ORDER BY account', [accountType]);
            for (var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                console.log("Account ID:", dbItem.account_id, "Account Name:", dbItem.account); // Log each retrieved item
                res[dbItem.account_id] = dbItem.account;
            }
        }
    );
    return res;
}

function insertAccount(account, accountType) {
    var db = getDatabase();
    var result;
    var newID = getNewID();
    console.log("ID: "+ newID +" Account Name: " + account + "TypeID: " + accountType)
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

function updateAccount(accountID, newName) {
    var db = getDatabase()
    var res = ""
    db.transaction(
        function(tx) {
            console.log("Account ID: "+ accountID);
            console.log("NewName Name: "+ newName);
            var rs = tx.executeSql("UPDATE accounts SET account=? WHERE account_id=?;",[newName, accountID]);
            if (rs.rowsAffected > 0) {
                res = "Insert on categories complited";
            } else {
                res = "Error";
            }
        }
    );
    return res;
}

function deleteAccount(accountID) {
    var db = getDatabase();
    var res, rs1, rs2;

    db.transaction(function(tx) {
        rs2 = tx.executeSql("DELETE FROM categories WHERE category='" + category + "';");
        if (rs2.rowsAffected > 0) res = "OK";
        else res = "Error";
    });

    return res;
}

function resetDatabase() {
    var db = getDatabase();

    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS accounts');
    });
    initializeDatabase();
}
