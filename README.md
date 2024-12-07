# Database-Engine

**Table:** `Customers`

**Columns:**
- `CustomerID`
- `CustomerName`	
- `ContactName`
- `Address`
- `City`	
- `PostalCode`	
- `Country`

## Step 1: Lex and Parse

Commands to parse through at the moment, given table:

#### SELECT
- `SELECT * FROM table_name;`
- `SELECT column1, column2, ... FROM table_name;`
- `SELECT column1, column2, ... FROM table_name WHERE condition;`

#### INSERT
- `INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);`
- `INSERT INTO table_name VALUES (value1, value2, value3, ...);`

#### UPDATE
- `UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;`

#### DELETE
- `DELETE FROM table_name WHERE condition;`

### Lexer
Convert string that includes sql statement to list of tokens. This will later be used in parser when using these token lists.
**Tokens:**
- `select`
- `insert`
- `into`
- `values`
- `update`
- `set`
- `where`
- `delete`
- `from`
- `=`
- `,`
- `*`
- `;`

## Step 2: Interpret

### B+ Trees

Very commonly used for data storing in databases. Will not use currently, but will look into implementing this in the near future, since this involves dealing with disk space.

### Sorted Files

Will use a sorted file, using page dictionaries to store data and query select through them.


## Resources

**SQLite Documentation/Open Source**
https://sqlite.org/src/doc/trunk/README.md

**Database from scratch**
https://www.youtube.com/watch?v=5Pc18ge9ohI

**SQL Statements**
https://www.w3schools.com/sql/default.asp

**Building Dune**
https://dune.readthedocs.io/en/stable/quick-start.html

**B+ Trees**
https://www.youtube.com/watch?v=scUtG_6M_lU&list=PLSE8ODhjZXjYDBpQnSymaectKjxCy6BYq&index=9

**Database Systems**
https://cs186berkeley.net/notes/note3/