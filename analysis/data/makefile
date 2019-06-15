############
# Makefile for beeranalysis
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
############

# Directory and mergedata outfile variables
DATADIR = .
MERGE_OUT = mergedata.Rout

# list variable RFILES for R gather and merge files
RFILES = $(wildcard $(DATADIR)/*.R)

# Creates OUT_FILES variable for .Rout files so that Make can
# tell how recently each R file was run.
OUT_FILES = $(RFILES:.R=.Rout)

# Makefile's default target. These are the files that we want make to 'make'
all: $(OUT_FILES)

# Run R files in RFILES
$(DATADIR)/%.Rout: $(DATADIR)/%.R
	R CMD BATCH $<  # The pre-requisite for target .Rout files is that they are run

# 'make clean' removes out files in OUT_FILES
clean:
	rm -fv $(OUT_FILES)

# 'make cleanMerge' removes mergedata.Rout
cleanMerge:
	rm -fv $(MERGE_OUT)