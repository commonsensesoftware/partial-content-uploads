LIBDIR := lib

# Email address used to submit drafts to the IETF datatracker.
# This must be either the datatracker account username or an active email
# address registered on that account; the submission API resolves it via
# User.username first, then falls back to matching an active Email record.
# `export` is required: lib/get-email.sh reads this from the environment,
# and lib/config.mk does not export it.
export UPLOAD_EMAIL := chris.s.martinez@outlook.com

include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
