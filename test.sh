#!/bin/bash
input="refs/head"

if [[ $BUILD_SOURCEBRANCH = refs/head/releases/* ]]
then
	echo "##vso[task.setvariable variable=Environment;isOutput=true]PreProduction"
elif [[ $BUILD_SOURCEBRANCH = refs/heads/master ]]
then
	echo "##vso[task.setvariable variable=Environment;isOutput=true]Production"
else
	echo "##vso[task.setvariable variable=Environment;isOutput=true]Development"
fi
