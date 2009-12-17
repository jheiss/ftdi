#!/usr/bin/ruby -w

# Simple libftdi usage example
# Translation of the example from
# http://www.intra2net.com/en/developer/libftdi/documentation/

require 'rubygems'
require 'ftdi'

# Not quite an exact translation of the C example (which statically allocates
# the ftdi_context and then calls ftdi_init on it, whereas I'm using ftdi_new
# to allocate and init in one shot so that I can avoid figuring out how to
# statically allocate a C struct from Ruby).  If someone wants to figure that
# out I think it would be nice for this script to be a more direct
# translation, the other examples can take shortcuts.
ftdic = Ftdi.ftdi_new

if (ret = Ftdi.ftdi_usb_open(ftdic, 0x0403, 0x6001)) < 0
  abort "unable to open ftdi device: #{ret} (#{Ftdi.ftdi_get_error_string(ftdic)})"
end

# Read out FTDIChip-ID of R type chips
if ftdic.type == Ftdi::TYPE_R
  chipid = IntPointer.new
  puts "ftdi_read_chipid: #{Ftdi.ftdi_read_chipid(ftdic, chipid)}"
  puts "FTDI chipid: #{chipid.value}"
end

Ftdi.ftdi_usb_close(ftdic)
Ftdi.ftdi_deinit(ftdic)

exit(true)

