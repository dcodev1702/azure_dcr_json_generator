# Azure DCR JSON Generator using Docker
A dockerized solution to generate Azure Data Collection Rule (DCR) JSON Sample Files from unstructured logs

Cited Resources:
-----------------
[Microsoft DCR Tutorial:](/https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal)
[Medium DCR Tutorial:](/https://koosg.medium.com/ingest-dcr-based-custom-logs-in-microsoft-sentinel-with-logstash-f94c79e69b93)


Assumptions:
------------
1. Docker is installed
2. You're connected to the Internet
3. You have the required access to build and run Docker containers
4. You can clone or download and unzip this repository


Instructions:
--------------
git clone https://github.com/dcodev1702/azure_dcr_json_generator.git
cd into cloned repository
docker build -t logstash_azure_dcr .
mkdir -p $(pwd)/tmp
chmod 755 generate_json_for_dcr_docker.sh
./generate_json_for_dcr_docker.sh


Post Condition:
----------------
The sample file: e.g. sampleFilexxxxxxxxxx.json will be in $(pwd)/tmp
You can use this file when creating a Custom Log via DCR at the transformation stage