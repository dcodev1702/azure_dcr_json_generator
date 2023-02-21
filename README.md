# Azure DCR JSON Generator using Docker
A dockerized solution using Logstash (v8.6.1) to generate Azure Data Collection Rule (DCR) JSON Sample Files from unstructured logs. <br />
An Apache2 Access log is used in this example. Limited testing has been done with single line log entries (Bind9 DNS & Apache2). <br />
<br />
This is inspired from using a Logstash container to ship unstructured logs to Log Analytics using the Custom Table (Log) DCR API. <br /> 
See cited resources below for a more detailed explanation.

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
You can use this file when creating a Custom Log in Log Analytics via DCR API at the KQL transformation stage <br />

Below is the JSON from the sample file stored in ./tmp. Once uploaded to Log Analytrics - Custom Table (DCR) <br />
you can write your KQL to normalize/transform the unstructured data to a structured format to your liking. <br />
See KQL_Apache2_AccessLog_Transformation.txt for an example. <br />
<br />
![Apache2_Logstash_Create_DCR_JSON](https://user-images.githubusercontent.com/32214072/220207309-39734a3b-1896-4e62-9337-4f2dccd0207d.jpg)
<br />
<br />
The Apache2 Access Log is now parsed (transformed) at ingestion time into several different distinct and queryable fields. <br />
<br />
![Apache2_Logstash_Create_DCR_Parsed](https://user-images.githubusercontent.com/32214072/220209620-3285f55d-95ee-478d-b021-3d5f58ed1aa3.jpg)
