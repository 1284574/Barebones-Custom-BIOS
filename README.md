# Barebones-Custom-BIOS


Bare metal program for our RISC-V machine and send a string ‘hello’ to the user, without depending on any supporting software on the running machine whatsoever (OS kernel, libraries, anything).

BIOS - the main purpose is to subsequently load the bootloader into the memory and hand-off the control to it

The bootloader is usually small and easy to load into the running memory and the processor can easily start running its code. It proceeds to load the operating system kernel into the memory.

Each machine loads the initial software in its own way. For example,the BIOS can be stored on a separate storage chip and upon powerup, the contents of the storage are simply filled into the memory at a fixed address and the processor just executes starting from that address.


Zero Stage Bootloader (ZSBL): Once you power on this virtual machine, QEMU fills the memory at 0x1000 with a few instructions and sets the program counter right to that address. This is the equivalent of a real machine having some hardcoded ROM firmware on the board and just dumping the contents into the RAM upon the bootup. You do not have the control over these instructions, i.e. they are not a part of your software image. The ZSBL sets up a few registers and jumps to address 0x80000000 which is where execution begins.

QEMU -bios flag: 0x80000000 is where the first user-provided instructions to QEMU are running, and they are loaded there as soon as the virtual machine starts. If don't pass anything, QEMU will use the default and load up a piece of software called OpenSBI. SBI is similar to BIOS.

The -bios flag is the ELF a binary file containing instructions and potentially some other data, organized into sections. ELF is the standard binary format for Linux

Simply put the ELF, is a key-value map where key is the starting address of a section, and the value is the bunch of bytes that need to be loaded into the memory at that address. Therefore, the ELF file provided to the -bios flag should fill out the memory starting at 0x80000000

-kernel flag is basically same as -bios flag

How does the machine then know to parse out the contents mapped to some address: 0x12345678 from the ELF file and load the memory with those. In a real machine, the software that is loaded upon the powerup is stored on the machine storage as a flat binary blob that is blindly just dumped into the memory upon the powerup, there is really no parsing involved

The 0x80000000 address is the location of the first user-provided instruction that the machine executes, why that is because the DRAM is mapped to start at the 0x80000000 in the address space.

We will build an ELF file that will lay some processor instructions at address 0x80000000 that will give the user a meassage 'hello'!

UART is a very simple device used for the most basic form of I/O: there is one wire of input (receiving known as RX) and one wire for output (transmit known as TX) and one bit goes onto the wire at the time. If connecting 2 devices one device's TX is the other device's RX and vice versa.

QEMU virtualizes an UART device on the virtual machine, and our software can access it. When you open the QEMU's serial port (UART) section, when you press a keyboard button, the code for that button is sent out of your host's TX to the VM's RX and when the VM outputs something on its TX, it will be rendered to you graphically in the terminal

QEMU maps UART at the address 0x10000000

If you send an 8-bit value to that address from your software, that will be sent out on the TX wire of the virtualized UART device, if you go to address 0x10000000 it will be rendered to console

 
