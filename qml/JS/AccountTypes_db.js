function getDatabase() {
    return LocalStorage.openDatabaseSync("MoneyManager", "1.0", "StorageDatabase", 1000000);
}

function getNumberOftables() {
    var db = getDatabase();
    var query = "SELECT COUNT(*) AS number_of_tables FROM sqlite_master WHERE type='table'";
    var res

    db.transaction(
        function(tx) {
            var rs = tx.executeSql(query);
            var dbItem = rs.rows.item(0);
            res = dbItem.number_of_tables
        }
    );
    return res;
}

function getNewID() {
    var db = getDatabase();
    var newID = 1;

    db.transaction(function (tx) {
        var rs = tx.executeSql('SELECT MAX(type_id) AS max_id FROM account_types');
        if (rs.rows.length > 0 && rs.rows.item(0).max_id !== null) {
            newID = rs.rows.item(0).max_id + 1;
        }
    });
    console.log(newID);
    return newID;
}

function initializeDatabase() {
    var db = getDatabase();

    db.transaction(
        function(tx) {
            // Create tables if they don't exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS account_types (type_id int NOT NULL PRIMARY KEY UNIQUE, account_type TEXT NOT NULL UNIQUE)');
            insertAccountType("Saving");
            insertAccountType("Current");
            insertAccountType("Card")
        }
    );
}

function getAllAccountTypes() {
    var db = getDatabase();
    var res = []

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT type_id, account_type FROM account_types');
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                res.push({type_id: dbItem.type_id, name: dbItem.account_type});
            }
        }
    );
    return res;
}

function insertAccountType(accountType) {
    var db = getDatabase();
    var res = "";
    var newID = getNewID();
    db.transaction(
        function(tx) {
            var rs = tx.executeSql('INSERT INTO account_types VALUES (?,?);', [newID, accountType]);
            if (rs.rowsAffected > 0) {
                res = "Insert on Account Types complited";
            } else {
                res = "Error";
            }
            console.log(res);
        }
    );
    return res;
}

function resetDatabase() {
    var db = getDatabase();

    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS Account_Types');
    });
    initializeDatabase();
}
