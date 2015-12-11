#!/bin/bash
if [ -d build ] then
  echo -n -e "\e[37mCreating build directory..."
  mkdir build
  echo -e "\e[32mDone!"
fi
echo -n -e "\e[37mCompiling binaries..."
nasm -f bin -o build/boot.bin src/boot.asm
nasm -f bin -o build/kernel.bin src/kernel/main.asm
echo -e "\e[32mDone!"
echo -n -e "\e[37mAssembling binaries..."
dd if=/dev/zero of=wintergreen.flp count=2880 status=noxfer
dd if=build/boot.bin of=wintergreen.flp conv=notrunc status=noxfer
dd if=build/kernel.bin of=wintergreen.flp seek=1 conv=notrunc status=noxfer
echo -e "\e[32mDone!"
echo -e "\e[36mEnjoy your new OS!\e[37m"
exit 0
