

#!/bin/bash



# Define variables

DB_HOST=${DATABASE_HOST}

DB_PORT=${DATABASE_PORT}

DB_NAME=${DATABASE_NAME}

DB_USER=${DATABASE_USER}

DB_PASSWORD=${DATABASE_PASSWORD}

MAX_CONNECTIONS=${NEW_MAX_CONNECTIONS}



# Increase the maximum number of connections in the PostgreSQL configuration

sudo -u postgres psql -h $DB_HOST -p $DB_PORT -d $DB_NAME -c "ALTER SYSTEM SET max_connections = $MAX_CONNECTIONS;"



# Reload the PostgreSQL configuration

sudo systemctl reload postgresql



# Verify that the new maximum number of connections is set

sudo -u postgres psql -h $DB_HOST -p $DB_PORT -d $DB_NAME -c "SHOW max_connections;"