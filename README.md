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
