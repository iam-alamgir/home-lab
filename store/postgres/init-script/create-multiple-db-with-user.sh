#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local dbCreds=$1

	if [[ "$dbCreds" == *":"* ]]; then
	    IFS="|:" read -r db_name user password <<< "$dbCreds"

	    echo "Creating database $db_name for user $user"

	    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE ROLE "$user" WITH LOGIN PASSWORD '$password';
	    CREATE DATABASE "$db_name" WITH OWNER "$POSTGRES_USER" TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
	    GRANT ALL ON DATABASE "$db_name" TO "$POSTGRES_USER";
	    \\connect "$db_name";
	    GRANT ALL ON SCHEMA public TO "$user";
EOSQL
	else
	    db_name=$dbCreds

	    echo "Creating database $db_name for user $POSTGRES_USER"

	    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE DATABASE "$db_name" WITH OWNER "$POSTGRES_USER" TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
	    GRANT ALL ON DATABASE "$db_name" TO "$POSTGRES_USER";
EOSQL
	fi
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested"
	IFS=',' read -ra dbCredsSet <<< "$POSTGRES_MULTIPLE_DATABASES"
	for dbCreds in "${dbCredsSet[@]}"; do
		create_user_and_database $dbCreds
	done
	echo "Multiple databases created"
fi
