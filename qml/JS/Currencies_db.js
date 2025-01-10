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
        var rs = tx.executeSql('SELECT MAX(currency_id) AS max_id FROM currencies');
        if (rs.rows.length > 0 && rs.rows.item(0).max_id !== null) {
            newID = rs.rows.item(0).max_id + 1;
        }
    });
    return newID;
}

function initializeDatabase() {
    var db = getDatabase();

    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS currencies(currency_id int NOT NULL PRIMARY KEY UNIQUE, currency TEXT NOT NULL, title TEXT NOT NULL, rate FLOAT NOT NULL, status BOOLEAN NOT NULL)');
            tx.executeSql('INSERT INTO currencies (currency_id, currency, title, rate, status) VALUES (?, ?, ?, ?, ?)', [1, "GBP", "British Pound", 1, "true"]);
        }
    );
}

function getAllCurrencies() {
    var db = getDatabase();
    var res = {};
    var newID = getNewID();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT currency_id, currency, title, rate FROM currencies where status =?', ["true"]);
        for (var i = 0; i < rs.rows.length; i++) {
            var dbItem = rs.rows.item(i);
            res[dbItem.currency_id] = {
                title: dbItem.title,
                currency: dbItem.currency,
                rate: dbItem.rate
            };
        }
    });

    return res;
}

function resetDatabase() {
    var db = getDatabase();

    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS currencies');
    });
    initializeDatabase();
}
