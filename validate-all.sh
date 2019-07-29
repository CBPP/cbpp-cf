#!/bin/bash -e

for i in $(grep -lr "Resources" $(find . -regex ".*\.\(yml\|yaml\)")); do
	echo "Validating: ${i}"
	aws cloudformation validate-template --template-body file://${i} > /dev/null
done

echo "All files successfully validated"
