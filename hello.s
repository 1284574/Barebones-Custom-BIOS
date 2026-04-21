# ELF file will lay out a few instructions at 0x80000000 to print characters
# Print the characters, 'h', 'e', 'l', 'l', 'o' to address 0x10000000

        .global _start  # _start is our assembly function
        .section .text.bios   # section is in .text of BIOS, where our code will be executed in memory (BIOS executes on startup of device)

_start: addi a0, x0, 0x68  # 0x68 - 'h'
      li a1, 0x10000000  # load dest address (UART device at that address)
      sb a0, (a1)  # 'h'

      addi a0, x0, 0x65
      sb a0, (a1)  # 'e'

      addi a0, x0, 0x6c
      sb a0, (a1) # 'l'
      
      addi a0, x0, 0x6c
      sb a0, (a1) # 'l'

      addi a0, x0, 0x6F
      sb a0, (a1) # 'o'

loop:   j loop
