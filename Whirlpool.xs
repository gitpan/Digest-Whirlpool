#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#include "_whirlpool.c"

typedef struct whirlpool {
    NESSIEstruct state;
}* Digest__Whirlpool;

MODULE = Digest::Whirlpool		PACKAGE = Digest::Whirlpool
PROTOTYPES: DISABLE

Digest::Whirlpool
new(...)
    CODE:
    {
        Newz(0, RETVAL, 1, struct whirlpool);
        NESSIEinit(&RETVAL->state);
    }

    OUTPUT:
        RETVAL

Digest::Whirlpool
clone(self)
	Digest::Whirlpool self
    CODE:
    {
        Newz(0, RETVAL, 1, struct whirlpool);
        Copy(&self->state, &RETVAL->state, 1, struct whirlpool);
    }

    OUTPUT:
        RETVAL

int
hashsize(...)
    CODE:
        RETVAL = 512;
    OUTPUT:
        RETVAL

Digest::Whirlpool
reset(self)
    Digest::Whirlpool self
    CODE:
        NESSIEinit(&self->state);
        
Digest::Whirlpool
add(self, ...)
    Digest::Whirlpool self
    CODE:
    {
        STRLEN len;
        unsigned char* data;
        unsigned int i;

        for (i = 1; i < items; i++) {
            data = (unsigned char*)(SvPV(ST(i), len));
            NESSIEadd(data, 8*len, &self->state);
        }
    }

SV*
digest(self)
    Digest::Whirlpool self
    CODE:
    {
        /* A bit (tr)?icky, makes sure the SvPV is 64 bytes then grabs
           its char* part and writes directly to it */
        RETVAL = newSVpv("", 64);
        NESSIEfinalize(&self->state, SvPV_nolen(RETVAL));
    }

    OUTPUT:
        RETVAL

void
DESTROY(self)
    Digest::Whirlpool self
    CODE:
        Safefree(self);

