#!/bin/bash

################################################################################
#
# Author: dcodev1702
# Date: 02.17.2023
# Purpose: Basic shell script to:
#  -- Check if Logstash is installed on system
#  -- Check if Microsoft Logstash Sentinel DCR Output Plugin is installed
#  -- Setup necessary directories -> /tmp/logstash
#  -- Copy STD|JSON logstash pipeline conf to /etc/logstash/conf.d/
#  -- Run logstash command to convert unstructured log entry to JSON 
#     format so DCR transformation can take place
#  -- Remove STDIN/JSON logstash pipeline file from /etc/logstash/conf.d/
#  -- Display (cat) Logstash Sentinel DCR files in JSON
#
###############################################################################

logstash_dir="/tmp/logstash"
logstash_conf="/usr/share/logstash/config"
logstash_json_conf="stdin-dcr-sentinel-sample.conf"
logstash_pipeline="/usr/share/logstash/pipeline"
apache2Log="apache2_accesslog_entry.txt"
container="temp_logstash"


echo -e "\e[32m\nGenerating Apache2 Log entry in JSON format for Data Collection Rule Transformation\e[0m"

# This command generates the JSON output from an Apache2 Log entry and stores the file in ./tmp/logstash
cat ./$apache2Log | docker run -i --rm --cpus="2.0" \
  -v "$(pwd)/jvm.options:$logstash_conf/jvm.options" \
  -v "$(pwd)/tmp:$logstash_dir" \
  -v "$(pwd)/logstash.yml:$logstash_conf/logstash.yml" \
  -v "$(pwd)/$logstash_json_conf:$logstash_pipeline/$logstash_json_conf" \
  $container -f "$logstash_pipeline/$logstash_json_conf"

echo -e "\033[33mGo to ./tmp and your sample JSON file will be there.\033[0m"
echo -e "\033[33mUpload this JSON file to DCR Transformation Editor in order to normalize the apache2 log entry for Log Analytics.\033[0m\n"

# Define the path to the directory containing the files
JSONFileDirectory="$(pwd)/tmp"

# Loop over the files in the directory
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
