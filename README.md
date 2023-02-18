# Azure DCR JSON Generator using Docker
A dockerized solution to generate Azure Data Collection Rule (DCR) JSON Sample Files from unstructured logs <br />
An Apache2 Access log is used in this example. Limited testing has been done with single line log entries (Bind9 DNS & Apache2).

Cited Resources:
-----------------
[Microsoft: Azure DCR API Tutorial](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal) <br />
[Medium: Azure DCR API Tutorial](https://koosg.medium.com/ingest-dcr-based-custom-logs-in-microsoft-sentinel-with-logstash-f94c79e69b93) <br />


Assumptions:
------------
1. Docker is installed
2. You're connected to the Internet
3. You have the required access to build and run Docker containers
4. You can clone or download and unzip this repository


Instructions:
--------------
```console
git clone https://github.com/dcodev1702/azure_dcr_json_generator.git
```
```console
cd azure_dcr_json_generator
```
```console 
docker build -t logstash_azure_dcr .
```
```console 
mkdir -p $(pwd)/tmp
```
```console 
chmod 755 generate_json_for_dcr_docker.sh
```
```console 
./generate_json_for_dcr_docker.sh
```
If you want to delete existing sample JSON files stored in ./tmp do the following <br />
```console
./generate_json_for_dcr_docker.sh 1
```

Post Condition:
----------------
The sample file: e.g. sampleFilexxxxxxxxxx.json will be in $(pwd)/tmp <br />
You can use this file when creating a Custom Log via DCR at the KQL transformation stage <br />
