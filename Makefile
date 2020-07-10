LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b master https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

IETFUSER=mcr+ietf@sandelman.ca
# because "make upload" never works for MCR. Yes, there are better ways.

upload: draft-ietf-rats-architecture-05.xml
	curl -S -F "user=${IETFUSER}" -F "xml=@draft-ietf-rats-architecture-05.xml" https://datatracker.ietf.org/api/submit

