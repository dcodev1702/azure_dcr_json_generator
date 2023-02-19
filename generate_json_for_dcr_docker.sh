#!/bin/bash

################################################################################
# Author: dcodev1702
# Date: 02.18.2023
# Purpose: Basic shell script to:
#  -- Map STD|JSON logstash pipeline conf to /usr/share/logstash/pipeline/
#  -- Map config files used by Logstash
#  -- Run logstash command to convert unstructured log entry to JSON 
#     format so DCR transformation, using Docker
#  -- Display (cat) Logstash Sentinel DCR files in JSON
#
#  Usage:
#  ---------
#  ./generate_json_for_dcr_docker.sh 
#     (Sets RM_JSON_FLAG=0 which will not delete existing JSON files stored in ./tmp)
#
#  ./generate_json_for_dcr_docker.sh 1 
#     (Sets RM_JSON_FLAG=1 which will delete existing JSON files stored in ./tmp)
#
###############################################################################

logstash_dir="/tmp/logstash"
logstash_conf="/usr/share/logstash/config"
logstash_json_conf="stdin-dcr-sentinel-sample.conf"
logstash_pipeline="/usr/share/logstash/pipeline"
apache2Log="apache2_accesslog_entry.txt"
container="logstash_azure_dcr"
RM_JSON_FLAG=0


# This sets the RM_JSON_FLAG if '1' is passed in via the cli -> ./generate_json_dcr_docker.sh 1
if [ "$#" -eq 1 ] && [ "$@" = 1 ]; then
   RM_JSON_FLAG=1
fi

# Create ./tmp directory for sample JSON file (output)
echo -e "\e[32m\nCreating tmp directory where the sample JSON file will reside\e[0m"
if [ -d "$(pwd)/tmp" ]; then
   echo -e "$(pwd)/tmp directory already exists\n"

   if [ $RM_JSON_FLAG -eq 1 ]; then
      sudo rm -rfv ./tmp/*.json
   fi
else
   mkdir -p -v "$(pwd)/tmp"
   echo -e "\033[33m$(pwd)/tmp directory successfully created..\033[0m\n"
fi


echo -e "\e[32m\nGenerating Apache2 Log entry in JSON format for Data Collection Rule Transformation\e[0m"

# This command generates the JSON output from an Apache2 Log entry and stores the file in ./tmp/logstash
cat ./$apache2Log | docker run -i --rm --cpus="2.0" \
  -v "$(pwd)/jvm.options:$logstash_conf/jvm.options" \
  -v "$(pwd)/tmp:$logstash_dir" \
  -v "$(pwd)/logstash.yml:$logstash_conf/logstash.yml" \
  -v "$(pwd)/$logstash_json_conf:$logstash_pipeline/$logstash_json_conf" \
  $container -f "$logstash_pipeline/$logstash_json_conf" > /dev/null 2>&1

echo -e "\033[33mGo to ./tmp and your sample JSON file will be there.\033[0m"
echo -e "\033[33mUpload this JSON file to DCR Transformation Editor in order to normalize the apache2 log entry for Log Analytics.\033[0m\n"

# Define the path to the directory containing the files
JSONFileDirectory="$(pwd)/tmp"

# Loop over the JSON files and display contents to STDOUT
for file in "$JSONFileDirectory"/*
do
  # Check if the file is a regular file (not a directory or a symlink)
  if [ -f "$file" ]; then

    # Print the name of the file
    echo -e "\e[32m\nFile: $file\e[0m"

    # Output the contents of the file
    cat "$file"; echo

  fi
done
