.PHONY: all clean

S = content

T = public_html

NEEDS = $(T)/index.html \

PANDOC = sed 's/\.md/\.html/g' | pandoc -s -c "http://www.columbia.edu/~akm2203/pandoc.css" --from markdown --to html5

HOME_LINK = sed -z 's/---\n\(.*\n\)*---\n/&\n[{Back to Home}](index.html)\n/'

define add_comments
$(HOME_LINK) | { cat - ;  printf "\n---------------\n\n### [Post comments]($(1))\n\nI am too technologically illiterate to set up a comment system on this page, but comments and questions are very welcome and encouraged through Github's issue system: [just click here]($(1))! (I know it's kind of a hack but it should work well enough.)\n" ; } | $(PANDOC)
endef

all : $(NEEDS)


$(T)/index.html : $(S)/index.md Makefile # still working here
	cat $< | $(PANDOC) > $@

$(T)/%.html : $(S)/%.md Makefile
	cat $< | $(HOME_LINK) | $(PANDOC) > $@

clean :
	rm -rf $(NEEDS)
