#!/bin/bash
echo -n -e "\e[37mCompiling binaries..."
nasm -f bin -o build/boot.bin src/boot.asm
echo -e "\e[32mDone!"
echo -n -e "\e[37mAssembling binaries..."
dd if=/dev/zero of=wintergreen.flp count=2880 status=noxfer
echo -e "\e[32mDone!"
echo -e "\e[36mEnjoy your new OS!"
exit 0
