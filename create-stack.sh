#!/bin/bash -e

if [ $# -lt 1 ]; then
  echo "usage: [TIER={test||prod}] $0 template"
  exit 1
fi

if [[ ${1} == *"tiered"* ]]; then
	if [[ -z "${TIER}" ]]; then
		echo "E: TIER not set"
		exit 1
	elif [[ ${TIER} == "test" ]] || [[ ${TIER} == "prod" ]]; then
		PARAMETERS=" --parameters ParameterKey=Tier,ParameterValue=${TIER} "
		POSTSTACK="-${TIER}"
	else
		echo "E: TIER invalid"
		exit 1
	fi	
fi

BASENAME=$(basename $1)

aws cloudformation create-stack --stack-name ${BASENAME%.*}${POSTSTACK} \
 --template-body file://$1 ${PARAMETERS} --capabilities CAPABILITY_IAM
