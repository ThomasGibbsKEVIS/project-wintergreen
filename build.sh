#!/bin/bash
if [ ! -d build ]
then
  echo -n -e "\e[37mCreating build folder..."
  mkdir build
  echo -e "\e[32mDone!"
fi
if [ -z ${1} ]
then
  echo -e "\e[37mNo architecture specified!"
  exit 1
fi
if [ -d src/arch/${1}/build.sh ]
then
  echo -e "\e[37mBuilding for \e[36m${1}\e[37m."
else
  echo -e "\e[37mInvalid architecture!"
fi
src/arch/${1}/build.sh
echo -e "\e[36mEnjoy your new OS!\e[37m"
exit 0
