#!/bin/bash
if [ -z `which nasm` ]
then
  echo -e "\e[34mnasm is required to build this software\e[37m"
  exit 1
else
  export nasm=`which nasm`
fi
if [ -z `which dd` ]
then
  echo -e "\e[34mcoreutils is required to build this software\e[37m"
  exit 1
else
  export dd=`which dd`
fi
if [ -d build ]
then
  echo -e "\e[36mBuild directory already has been created!"
else
  echo -n -e "\e[37mCreating build directory..."
  mkdir build
  echo -e "\e[32mDone!"
fi
echo -n -e "\e[37mAssembling binaries..."
$nasm -f bin -o build/boot.bin src/boot.asm
$nasm -f bin -o build/filesystem.bin src/filesystem.asm
$nasm -f bin -o build/kernel.bin src/kernel/main.asm
$nasm -f bin -o build/shell.bin src/shell/main.asm
echo -e "\e[32mDone!"
echo -e "\e[37mBuilding image..."
echo -n -e "\e[s"
$dd if=/dev/zero of=wintergreen.flp conv=notrunc count=2880 status=noxfer
echo -n -e "\e[u\e[K\e[B\e[K\e[u"
$dd if=build/boot.bin of=wintergreen.flp conv=notrunc status=noxfer
echo -n -e "\e[u\e[K\e[B\e[K\e[u"
$dd if=build/filesystem.bin of=wintergreen.flp conv=notrunc status=noxfer seek=1
echo -n -e "\e[u\e[K\e[B\e[K\e[u"
$dd if=build/kernel.bin of=wintergreen.flp conv=notrunc status=noxfer seek=2
echo -n -e "\e[u\e[K\e[B\e[K\e[u"
$dd if=build/shell.bin of=wintergreen.flp conv=notrunc status=noxfer seek=35
echo -n -e "\e[u\e[K\e[B\e[K\e[u\e[A"
echo -e "\e[37mBuilding image...\32mDone!"
echo -e "\e[36mEnjoy your new OS!"
exit 0
