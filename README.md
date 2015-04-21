# REDCap to Harvest

Dockerfile and tools for deriving Harvest applications from REDCap projects.

## Requirements

- [Docker](http://docs.docker.com/installation/)

## Run

The Docker file relies on the REDCap data dictionary and data file to build the Harvest application. These files must be made available by mounting a volume to `/input` containing these files. By default the file names are `metadata.csv` and `data.csv`, however these can be configured by setting the `$METADATA_FILE` and `$DATA_FILE` environment variables.

To run an interactive container:

```bash
docker run --rm -it -p 8000:8000 -v /path/to/your/input:/input dbhi/redcap-harvest
```

The startup script will build a SQLite database for Harvest from the metadata and data files and then end with running the Django server on port 8000.

## Extending

The intent of this image is to provide an ephemeral, read-only Harvest application representative of a REDCap project, however it may be desirable to persist metadata changes and saved queries over time. This is straightforward to accomplish by providing a custom `local_settings.py` file. At a minimum the following settings are required.

```python
from global_settings import INSTALLED_APPS

INSTALLED_APPS += (
    'djredcap',
)

MODELTREES = {
    'default': {
        'model': 'Record',
    }
}

SECRET_KEY='abc123'
```

To define a custom database, simply define the Django `DATABASES` setting. This example assumes a container `db` will be linked to this one.

```python
# ..[snip]..

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'HOST': 'db',
        'PORT': 5432,
        'USER': 'postgres',
    },
}
```

The corresponding Dockerfile would look something like this:


```dockerfile
FROM dbhi/redcap-harvest

# Install postgresql bindings
RUN pip install psycopg2

# The current working directory is /usr/src/app/project
ADD local_settings.py ./project/conf/
```
