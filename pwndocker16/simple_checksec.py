#!/usr/bin/python3
from pwn import *
import sys
m_elf = ELF(sys.argv[1])