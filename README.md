
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Connection pool exhaustion in PostgreSQL.
---

Connection pool exhaustion is a common incident that occurs when an application is unable to create new database connections due to a high number of existing connections. This happens when the application's connection pooling configurations are inadequate and unable to handle the traffic. This incident can lead to degraded application performance or even application failure. To resolve this issue, the application's connection pooling configurations must be optimized to ensure that the connection pool can handle the application's traffic without exhausting its resources.

### Parameters
```shell
export APPLICATION_CONFIG_FILE="PLACEHOLDER"

export APPLICATION_LOG_FILE="PLACEHOLDER"

export DATABASE_NAME="PLACEHOLDER"

export DATABASE_HOST="PLACEHOLDER"

export DATABASE_USER="PLACEHOLDER"

export NEW_MAX_CONNECTIONS="PLACEHOLDER"

export DATABASE_PORT="PLACEHOLDER"

export DATABASE_PASSWORD="PLACEHOLDER"
```

## Debug

### Check the maximum number of connections allowed in PostgreSQL
```shell
sudo -u postgres psql -c "SHOW max_connections;"
```

### Check the current number of connections in PostgreSQL
```shell
sudo -u postgres psql -c "SELECT count(*) FROM pg_stat_activity;"
```

### Check the number of idle connections in PostgreSQL
```shell
sudo -u postgres psql -c "SELECT count(*) FROM pg_stat_activity WHERE state = 'idle';"
```

### Check the connection pool size in the application's configuration file
```shell
grep "connection_pool_size" ${APPLICATION_CONFIG_FILE}
```

### Check the connection timeout setting in the application's configuration file
```shell
grep "connection_timeout" ${APPLICATION_CONFIG_FILE}
```

### Check the maximum number of connections allowed by the application's connection pool
```shell
grep "max_connections" ${APPLICATION_CONFIG_FILE}
```

### Check the application's logs for connection-related errors
```shell
tail -n 100 ${APPLICATION_LOG_FILE}
```

## Repair

### Increase the maximum number of connections allowed by the connection pool to ensure that the pool can handle the application's traffic without exhausting its resources.
```shell


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


```