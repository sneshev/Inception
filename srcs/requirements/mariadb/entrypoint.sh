#!/bin/bash

INITDIR="."
INITFILE="init.sql"


if [ -f "$INITDIR/$INITFILE" ]; then 
    echo "$INITFILE already exists.."
    echo "Starting mysqld.."
    exec "$@"
else 
    echo "creating \"$INITFILE\" file in directory \"$INITDIR\""

    ESCPD_USER=$(echo "$DB_USER_NAME" | sed "s/'/''/g")
    ESCPD_USERPASS=$(echo "$DB_USER_PASS" | sed "s/'/''/g")
    ESCPD_ROOTPASS=$(echo "$DB_ROOT_PASS" | sed "s/'/''/g")
    
    cat > "$INITDIR/$INITFILE" \
    << EOF
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '$ESCPD_ROOTPASS';

CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;

CREATE USER IF NOT EXISTS '$ESCPD_USER'@'%' IDENTIFIED BY '$ESCPD_USERPASS';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$ESCPD_USER'@'%';

FLUSH PRIVILEGES;
EOF

    echo "Starting mysqld.."
    mysqld --user=mysql --init-file=/init.sql --bind-address=0.0.0.0
fi
