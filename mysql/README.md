# MySQL configuration

The file database_setup.sql contains the commands to create the database called "energy" with a table called "electric" in it.

Take the following steps to set up the database -
* After the terraform apply has deployed the mysql container, run `docker logs MySQL_consumption` and find the generated root password.  Hint.  Its preceeded by `GENERATED ROOT PASSWORD`
* Run `mysql -h 127.0.0.1 -u root -p < database_setup.sql`.  Enter the password when prompted

The database is now set up
