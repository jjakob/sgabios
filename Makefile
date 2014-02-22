# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# $Id$

BUILD_CL = \"PnP\"
BUILD_DATE = \"$(shell date -u)\"
BUILD_SHORT_DATE = \"$(shell date -u +%D)\"
BUILD_HOST = \"$(shell hostname)\"
BUILD_USER = \"$(shell whoami)\"

#CFLAGS = -Wall -O2 -s
CFLAGS := -Wall -Os -m32 -nostdlib

ASFLAGS := $(CFLAGS)
ASFLAGS += -DBUILD_CL="$(BUILD_CL)"
ASFLAGS += -DBUILD_DATE="$(BUILD_DATE)"
ASFLAGS += -DBUILD_SHORT_DATE="$(BUILD_SHORT_DATE)"
ASFLAGS += -DBUILD_HOST="$(BUILD_HOST)"
ASFLAGS += -DBUILD_USER="$(BUILD_USER)"

.SUFFIXES: .bin .tmpbin

all: sgabios.bin

# FIXME: should calculate the size by rounding it up to the nearest
# 512-byte boundary
#sgabios.bin: sgabios.tmpbin buildrom.py
#	./buildrom.py sgabios.tmpbin sgabios.bin

sgabios.bin: Makefile sgabios.S config.h

.S.bin:
	$(CC) -c $(ASFLAGS) $*.S -o $*.o
	$(LD) -melf_i386 -Ttext 0x0 -s --nostdlib --oformat binary $*.o -o $*.bin

clean:
	$(RM) *.s *.o *.bin *.srec *.com
