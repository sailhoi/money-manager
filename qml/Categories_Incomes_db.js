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

function initializeDatabase() {
    var db = getDatabase();

    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS categories(category TEXT NOT NULL PRIMARY KEY UNIQUE)');
        }
    );
}

function getAllCategories() {
    var db = getDatabase();
    var res = []

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT category FROM categories');
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                res.push(dbItem.category);
            }
        }
    );
    return res;
}

function insertCategory(category) {
    var db = getDatabase()
    var res = ""

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('INSERT INTO categories VALUES (?);', [category]);
            if (rs.rowsAffected > 0) {
                res = "Insert on categories complited";
            } else {
                res = "Error";
            }
        }
    );
    return res;
}

function updateCategory(oldName, newName) {
    var db = getDatabase()
    var res = ""
    db.transaction(
        function(tx) {
            console.log("Old Name: "+ oldName);
            console.log("NewName Name: "+ newName);
            var rs = tx.executeSql("UPDATE categories SET category=? WHERE category=?;",[newName, oldName]);
            if (rs.rowsAffected > 0) {
                res = "Insert on categories complited";
            } else {
                res = "Error";
            }
        }
    );
    return res;
}

function deleteCategory(category) {
    var db = getDatabase();
    var res, rs1, rs2;

    db.transaction(function(tx) {
        rs2 = tx.executeSql("DELETE FROM categories WHERE category='" + category + "';");
        if (rs2.rowsAffected > 0) res = "OK";
        else res = "Error";
    });

    return res;
}

function reset() {
    var db = getDatabase();
    db.transaction(
        function(tx) {
            tx.executeSql('DROP TABLE categories')
      });
    initializeDatabase();
}
