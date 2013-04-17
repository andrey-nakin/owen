##############################################################################
# demo.tcl --
#
# This file is part of owen Tcl library.
#
# Copyright (c) 2011 Andrey V. Nakin <andrey.nakin@gmail.com>
# All rights reserved.
#
# See the file "COPYING" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
##############################################################################

##############################################################################
# Simple script demonstrating usage of OWEN Tcl library
# Usage:
#   demo.tcl <port> <addr> <addrType - 0 or 1>
##############################################################################

package require owen

# default parameters
set port COM1
set addr 16
set addrType $::owen::ADDR_TYPE_8BIT

proc write { msg res } {
    if { [::owen::lastStatus] != $::owen::STATUS_PORT_ERROR } {
        puts "$msg\t$res\tlastStatus=[::owen::lastStatus]\tlastError=[format 0x%0.2x [::owen::lastError]]"    
    } else {
        puts "$msg\t$res\tlastStatus=[::owen::lastStatus]\tlastError=[::owen::lastError]"    
    }
}

# Entry point

# Read command line parameters
if { [llength $argv] > 0 } {
    set port [lindex $argv 0]
}
if { [llength $argv] > 1 } {
    set addr [lindex $argv 1]
}
if { [llength $argv] > 2 } {
    set addrType [lindex $argv 2]
}

# Create a device descriptor
set desc [::owen::configure -port $port -addr $addr -addrType $addrType]

# Read/write parameters
write "send APLY" [::owen::sendCommand $desc aply]
write "read DEV " [::owen::readString $desc dev]
write "read PV " [::owen::readFloat24 $desc pv]
write "read Sl.L " [::owen::readFloat24 $desc sl.l 0]
write "read Sl.h " [::owen::readFloat24 $desc sl.h 0]
write "write SP" [::owen::writeFloat24 $desc sp 0 33.33333]
write "read SP " [::owen::readFloat24 $desc sp 0]
write "write in.t" [::owen::writeInt8 $desc in.t 0 16]
write "read in.t" [::owen::readInt $desc in.t 0]
write "write addr" [::owen::writeInt16 $desc addr -1 16]
write "read addr" [::owen::readInt $desc addr]
write "read dPt" [::owen::readInt $desc dPt 0]
