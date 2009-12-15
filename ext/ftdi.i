%module ftdi

%include "carrays.i"
%include "cdata.i"

%array_class(unsigned char, UnsignedCharArray);

%{
#include <ftdi.h>
%}

%include "ftdi.h"

