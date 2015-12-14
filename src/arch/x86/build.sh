#!/bin/bash
if [ -z `which nasm` ]
then
  echo -e "\[37mnasm is required to build for the x86 architecture!"
fi
if [ -z `which dd` ]
then
  echo -e "\[37mcoreutils is required to build for the x86 architecture!"
fi
export nasm=`which nasm`
export dd=`which dd`
echo -n -e "\e[37mAssembling binaries..."
$nasm -f bin -o build/boot.bin src/arch/x86/boot.asm
$nasm -f bin -o 
echo -e "\e[32mDone!"
echo -e "\e[37mBuilding floppy image..."
# TODO: Later find a way to suppress dd output
$dd if=/dev/null of=wintergreen_x86.flp count=2880 conv=notrunc status=noxfer
$dd if=build/boot.bin of=wintergreen_x86.flp conv=notrunc status=noxfer
$dd if=build/kernel.bin of=wintergreen_x86.flp skip=1 conv=notrunc status=noxfer
echo -e "\e[32mDone!"
echo -n -e "\e[37mCleaning up..."
rm -f build/boot.bin
rm -f build/kernel.bin
echo -e "\e[32mDone!"
exit 0
