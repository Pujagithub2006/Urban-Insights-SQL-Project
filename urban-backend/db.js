const mysql = require('mysql2');

const conn = mysql.createPool({
    host: 'localhost',
    user: 'root', 
    password: 'PujaSQL@2006',
    database: 'urban_insights',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
})

module.exports = conn;