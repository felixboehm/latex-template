# IUBH LaTeX Template Makefile
# 
# This Makefile automates the compilation process for the IUBH LaTeX template
# using pdflatex and biber for bibliography processing.

# Configuration
MAIN_TEX = 00-Main
BUILD_DIR = build
OUTPUT_PDF = $(BUILD_DIR)/$(MAIN_TEX).pdf

# LaTeX compilation commands
PDFLATEX = pdflatex
BIBER = biber
PDFLATEX_FLAGS = -interaction=nonstopmode -output-directory=$(BUILD_DIR)
BIBER_FLAGS = --output-directory $(BUILD_DIR)

# Source files
TEX_FILES = $(wildcard *.tex)
BIB_FILES = $(wildcard *.bib)
STYLE_FILES = $(wildcard *.bst)
PIC_FILES = $(wildcard pics/*)

# Default target
.PHONY: all
all: $(OUTPUT_PDF)

# Main compilation target
$(OUTPUT_PDF): $(TEX_FILES) $(BIB_FILES) $(STYLE_FILES) $(PIC_FILES) | $(BUILD_DIR)
	@echo "Compiling LaTeX document..."
	$(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN_TEX).tex
	@echo "Running biber for bibliography..."
	$(BIBER) $(BIBER_FLAGS) $(MAIN_TEX)
	@echo "Second pdflatex run..."
	$(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN_TEX).tex
	@echo "Final pdflatex run..."
	$(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN_TEX).tex
	@echo "Compilation complete: $(OUTPUT_PDF)"

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Quick compile (single pdflatex run)
.PHONY: quick
quick: | $(BUILD_DIR)
	@echo "Quick compilation (single run)..."
	$(PDFLATEX) $(PDFLATEX_FLAGS) $(MAIN_TEX).tex

# Bibliography only
.PHONY: bib
bib: | $(BUILD_DIR)
	@echo "Processing bibliography..."
	$(BIBER) $(BIBER_FLAGS) $(MAIN_TEX)

# Clean build directory
.PHONY: clean
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)/*
	@echo "Cleaning LaTeX output files from root directory..."
	rm -f *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.pdf *.run.xml *.toc *.fls *.fdb_latexmk *.synctex.gz *.out *.nav *.snm

# Clean everything including build directory
.PHONY: distclean
distclean:
	@echo "Removing build directory..."
	rm -rf $(BUILD_DIR)

# Open the generated PDF
.PHONY: open
open: $(OUTPUT_PDF)
	@echo "Opening PDF..."
	open $(OUTPUT_PDF)

# Watch for changes and recompile (requires fswatch)
.PHONY: watch
watch:
	@echo "Watching for changes... (Press Ctrl+C to stop)"
	@command -v fswatch >/dev/null 2>&1 || { echo >&2 "fswatch not installed. Install with: brew install fswatch"; exit 1; }
	fswatch -o $(TEX_FILES) $(BIB_FILES) | while read num; do \
		echo "Changes detected, recompiling..."; \
		$(MAKE) all; \
	done

# Install required packages (for BasicTeX)
.PHONY: install-packages
install-packages:
	@echo "Installing required LaTeX packages..."
	sudo tlmgr update --self
	sudo tlmgr install chngcntr scrhack biblatex biber logreq
	sudo tlmgr install txfonts caption float geometry setspace
	sudo tlmgr install microtype graphicx placeins acronym
	sudo tlmgr install hyperref xstring etoolbox url
	sudo tlmgr install babel babel-english inputenc
	sudo tlmgr install biblatex-apa csquotes
	sudo tlmgr install koma-script tools

# Install packages in user mode (no sudo required)
.PHONY: install-packages-user
install-packages-user:
	@echo "Installing required LaTeX packages in user mode..."
	tlmgr init-usertree
	tlmgr --usermode install bigfoot
	tlmgr --usermode install chngcntr scrhack biblatex biber logreq
	tlmgr --usermode install txfonts caption float geometry setspace
	tlmgr --usermode install microtype graphicx placeins acronym
	tlmgr --usermode install hyperref xstring etoolbox url
	tlmgr --usermode install babel babel-english inputenc
	tlmgr --usermode install biblatex-apa csquotes
	tlmgr --usermode install koma-script tools

# Show compilation log
.PHONY: log
log:
	@if [ -f $(BUILD_DIR)/$(MAIN_TEX).log ]; then \
		echo "=== LaTeX Log ==="; \
		cat $(BUILD_DIR)/$(MAIN_TEX).log; \
	else \
		echo "No log file found. Run 'make' first."; \
	fi

# Show bibliography log
.PHONY: biblog
biblog:
	@if [ -f $(BUILD_DIR)/$(MAIN_TEX).blg ]; then \
		echo "=== Biber Log ==="; \
		cat $(BUILD_DIR)/$(MAIN_TEX).blg; \
	else \
		echo "No bibliography log found. Run 'make' first."; \
	fi

# Show help
.PHONY: help
help:
	@echo "IUBH LaTeX Template Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all                  - Compile the complete document (default)"
	@echo "  quick               - Quick compile (single pdflatex run)"
	@echo "  bib                 - Process bibliography only"
	@echo "  clean               - Clean build directory contents"
	@echo "  clean-root          - Clean LaTeX output files from root directory"
	@echo "  distclean           - Remove entire build directory"
	@echo "  open                - Open the generated PDF"
	@echo "  watch               - Watch for changes and auto-recompile"
	@echo "  install-packages    - Install required packages (requires sudo)"
	@echo "  install-packages-user - Install packages in user mode"
	@echo "  log                 - Show LaTeX compilation log"
	@echo "  biblog              - Show bibliography processing log"
	@echo "  help                - Show this help message"
	@echo ""
	@echo "Output: $(OUTPUT_PDF)"
