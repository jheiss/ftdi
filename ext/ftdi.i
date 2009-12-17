%module ftdi

%include "cpointer.i"
%include "carrays.i"
%include "cdata.i"

/* Wrap a class interface around an "int *" */
/* http://www.swig.org/Doc1.3/SWIGDocumentation.html#Library_nn4 */
%pointer_class(int, IntPointer);

/* Wrap a class interface around an "unsigned char *" */
/* http://www.swig.org/Doc1.3/SWIGDocumentation.html#Library_nn7 */
%array_class(unsigned char, UnsignedCharArray);

%{
#include <ftdi.h>
%}

%include "ftdi.h"

