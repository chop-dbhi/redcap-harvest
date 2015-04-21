# REDCap to Harvest

Dockerfile and tools for deriving Harvest applications from REDCap projects.

Installation and Setup
----------------------

This tool runs using Docker. Install it if you don't have it:

[Install Docker](http://docs.docker.com/installation/) 

In order to run the container, you need to place your data dictonary and data file in a folder. Name the data dictonary and data file "metadata.csv" and "data.csv", respectively.

Now run the container:

```bash
docker run --rm -it -p 8001:8000 -v path/to/your/inputfolder:/input dbhi/redcap-harvest
```

The Harvest server will report the IP it is running at, which should be 0.0.0.0:8000.
The run command above maps the container's 8000 port to your machine's 8001. so the IP is0.0.0.0:8001.
Go to this IP in your web browser to be brought to a new Harvest instance with your data.

Note:
If you are running this on Mac, this IP will not be correct. (It is the IP in the Virtual Machine the container is running in.)
To get the correct IP, type:
```bash
boot2docker ip
```
The correct IP address is:
```bash
<output from boot2docker ip>:8001
```
