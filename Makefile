LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

# because "make upload" never works for MCR. Yes, there are better ways.
VER=12
IETFUSER=mcr+ietf@sandelman.ca
mcrsend: draft-ietf-rats-architecture-${VER}.xml
	curl -S -F "user=${IETFUSER}" -F "xml=@draft-ietf-rats-architecture-${VER}.xml" https://datatracker.ietf.org/api/submit

