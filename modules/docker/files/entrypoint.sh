#!/bin/bash

# install python & pip:
yum install -y python3 python3-pip
# install awscli:
pip3 install awscli

if [[ -d /root/.aws ]]; then
	export STREAM_NAME='terraform-kinesis-test'
	I=0
	while true; do 
	    echo "THE RANDOM IS: ${RANDOM}"; 
	    echo "PREVIOUS NUMBER IS: ${I}"; I=$((${I} + 1)); 
	    echo "THE NEW NUMBER IS: ${I}";
	    # send record to kinesis:
	    aws --endpoint-url http://172.17.0.1:4568 kinesis put-record --stream-name ${STREAM_NAME} --partition-key ${I} --data ${RANDOM};
	    sleep 3; 
	done;
else
	exec /bin/bash
fi
