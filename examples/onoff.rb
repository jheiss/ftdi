#!/usr/bin/ruby -w

# An example using bitbang mode which turns all 8 pins off, waits a second,
# then all on and waits for a second, then off and exits.

require 'rubygems'
require 'ftdi'

puts 'ftdi_new'
ftdi1 = Ftdi.ftdi_new

puts 'ftdi_usb_open_desc ?'
if (r = Ftdi.ftdi_usb_open_desc(ftdi1, 0x0403, 0x6001, 'USBMOD4', '?')) < 0
  abort "unable to open ftdi device: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

puts 'ftdi_enable_bitbang'
if (r = Ftdi.ftdi_enable_bitbang(ftdi1, 0xFF)) < 0
  abort "unable to enable bitbang mode: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

buf = Ftdi::UnsignedCharArray.new(1)
buf[0] = 0x0
puts 'turning everything off'
if (r = Ftdi.ftdi_write_data(ftdi1, buf, 1)) < 0
  abort "unable to write data: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

sleep 1

buf[0] = 0xFF
puts 'turning everything on'
if (r = Ftdi.ftdi_write_data(ftdi1, buf, 1)) < 0
  abort "unable to write data: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

sleep 1

buf[0] = 0x0
puts 'turning everything off'
if (r = Ftdi.ftdi_write_data(ftdi1, buf, 1)) < 0
  abort "unable to write data: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

puts 'ftdi_disable_bitbang'
if (r = Ftdi.ftdi_disable_bitbang(ftdi1)) < 0
  abort "unable to disable bitbang mode: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

puts 'ftdi_usb_close'
if (r = Ftdi.ftdi_usb_close(ftdi1)) < 0
  abort "unable to close ftdi device: #{r} (#{Ftdi.ftdi_get_error_string(ftdi1)})"
end

