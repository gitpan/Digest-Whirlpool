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

int
hashsize(...)
    CODE:
        RETVAL = 512;
    OUTPUT:
        RETVAL

void
reset(self)
    Digest::Whirlpool self
    CODE:
        NESSIEinit(&self->state);
        
void
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

