#!/bin/bash

INITDIR="."
INITFILE="init.sql"


if [ -f "$INITDIR/$INITFILE" ]; then 
    echo "$INITFILE already exists.."
    echo "Starting mysqld.."
    exec "$@"
elif [[ ! "$DATABASE" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "invalid database name"
    exit 1
else 
    echo "creating \"$INITFILE\" file in directory \"$INITDIR\""

    ESCPD_USER=$(echo "$USER" | sed "s/'/''/g")
    ESCPD_USERPASS=$(echo "$USERPASS" | sed "s/'/''/g")
    ESCPD_ROOTPASS=$(echo "$ROOTPASS" | sed "s/'/''/g")
    
    cat > "$INITDIR/$INITFILE" \
    << EOF
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '$ESCPD_ROOTPASS';

CREATE DATABASE IF NOT EXISTS $DATABASE;

CREATE USER IF NOT EXISTS '$ESCPD_USER'@'%' IDENTIFIED BY '$ESCPD_USERPASS';
GRANT ALL PRIVILEGES ON $DATABASE.* TO '$ESCPD_USER'@'%';

FLUSH PRIVILEGES;
EOF

    echo "Starting mysqld.."
    mysqld --user=mysql --init-file=/init.sql --bind-address=0.0.0.0
fi
