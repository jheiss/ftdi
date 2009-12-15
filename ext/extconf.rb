require 'mkmf'
idir, ldir = dir_config('ftdi')
have_library('ftdi', 'ftdi_init')

# Swig seemingly has no notion of searching any standard system directories
# for included header files.  And figuring out where the user has ftdi
# installed is potentially tricky.  Seems like there are three
# possibilities for where mkmf will end finding ftdi:
# - Installed in a standard system location searched by cpp by default
# - Installed in the same location as Ruby, as mkmf adds
#   Config::CONFIG['CPPFLAGS'] to the compiler args, and thus adds the include
#   directory associated with the Ruby install location even if cpp wouldn't
#   normally check there by default.
# - A location specified by the user at install time via the dir_config
#   feature
# This all seems horribly cheesy, so if a someone who knows anything about
# swig happens to read this I'd appreciate pointers on how other folks handle
# this.
ftdi_includes = []
# Standard system locations
IO.popen('cpp -M -include ftdi.h < /dev/null') do |pipe|
  pipe.each do |line|
    line.split(' ').each do |inc|
      if inc.include?('/ftdi.h')
        ftdi_includes << '-I' + inc
      end
    end
  end
end
# Any -I directories in Config::CONFIG['CPPFLAGS']
Config::CONFIG['CPPFLAGS'].split(' ').each do |rbcppflag|
  if rbcppflag =~ /^-I/
    ftdi_includes << rbcppflag
  end
end
# User specified directory via dir_config
if idir
  ftdi_includes << '-I' + idir
end
system("swig -ruby #{ftdi_includes.uniq.join(' ')} ftdi.i") || abort("swig failed")

create_makefile("ftdi")

