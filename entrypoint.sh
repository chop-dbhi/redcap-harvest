#!/bin/bash

PYTHONPATH=.

# Setup the database if this is the first time.
if [ ! -e metadata.json ]; then
    echo 'Interpreting data dictionary...'
    python bin/manage.py redcap json /input/$METADATA_FILE

    echo 'Generating models...'
    python bin/manage.py redcap models metadata.json -o project/models.py

    echo 'Creating fixtures from data...'
    python bin/manage.py redcap fixture /input/$DATA_FILE metadata.json project

    echo 'Synchronizing database...'
    python bin/manage.py syncdb

    echo 'Loading data...'
    python bin/manage.py loaddata fixtures.json

    echo 'Intializing Avocado metadata...'
    python bin/manage.py avocado init project

    echo 'Done.'
fi

"$@"
