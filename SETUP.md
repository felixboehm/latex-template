# IUBH LaTeX Template Setup Guide

This guide documents the complete setup process for compiling the original IUBH LaTeX template using BasicTeX and full TeX distributions.

## 1. Overview

The IUBH LaTeX template is a professional academic document template for seminar works, bachelor's theses, and master's theses at the International University of Applied Sciences Bad Honnef (IUBH). The template provides a complete structure with title page, table of contents, bibliography, and academic formatting.

## 2. System Requirements

### Minimum Requirements
- LaTeX distribution (BasicTeX, TeX Live, or MiKTeX)
- PDF viewer
- Text editor
- Biber or BibTeX for bibliography processing

### Recommended Setup
- Full TeX Live distribution (includes all packages)
- VS Code with LaTeX Workshop extension
- 2GB free disk space
- Admin privileges for package installation

## 3. LaTeX Distribution Installation

### Option A: Full TeX Live (Recommended)
**macOS:**
```bash
# Install MacTeX (full distribution)
brew install mactex-no-gui
# or download from: https://tug.org/mactex/
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install texlive-full

# Fedora/RHEL
sudo dnf install texlive-scheme-full
```

**Windows:**
- Download and install MiKTeX from: https://miktex.org/download
- Or install TeX Live from: https://tug.org/texlive/

### Option B: BasicTeX + Manual Package Installation
**macOS:**
```bash
# Install BasicTeX
brew install basictex

# Add to PATH
export PATH="/usr/local/texlive/2025basic/bin/universal-darwin:$PATH"
```

## 4. Required Packages

The IUBH template requires the following LaTeX packages:

### Core Packages (Required)
```
chngcntr        # Counter management
scrhack         # KOMA-Script fixes
biblatex        # Modern bibliography management
txfonts         # Times fonts
caption         # Enhanced captions
float           # Float positioning
geometry        # Page layout
setspace        # Line spacing
microtype       # Typography improvements
graphicx        # Graphics inclusion
placeins        # Float barriers
acronym         # Acronym management
hyperref        # Hyperlinks and bookmarks
```

### Additional Dependencies
```
biber           # Bibliography processor (backend for biblatex)
logreq          # Logging requests
xstring         # String manipulation
etoolbox        # Programming tools
url             # URL formatting
babel           # Language support
inputenc        # Input encoding
```

## 5. Package Installation

### For BasicTeX Users
Install all required packages using tlmgr:

```bash
# Update package manager
sudo tlmgr update --self

# Install core packages
sudo tlmgr install chngcntr scrhack biblatex biber logreq
sudo tlmgr install txfonts caption float geometry setspace
sudo tlmgr install floatbytocbasic setspaceenhanced
sudo tlmgr install microtype graphicx placeins acronym
sudo tlmgr install hyperref xstring etoolbox url
sudo tlmgr install babel babel-english inputenc

# Install additional dependencies
sudo tlmgr install biblatex-apa csquotes suffix
sudo tlmgr install koma-script tools
```

### User Mode Installation (No sudo required)
If you don't have admin privileges or prefer user-mode installation:

```bash
# Initialize user tree
tlmgr init-usertree

# Install packages in user mode
tlmgr --usermode install bigfoot
tlmgr --usermode install chngcntr scrhack biblatex biber logreq
tlmgr --usermode install txfonts caption float geometry setspace
tlmgr --usermode install floatbytocbasic setspaceenhanced
tlmgr --usermode install microtype graphicx placeins acronym
tlmgr --usermode install hyperref xstring etoolbox url
tlmgr --usermode install babel babel-english inputenc
tlmgr --usermode install biblatex-apa csquotes
tlmgr --usermode install koma-script tools
```

Note: The `bigfoot` package provides the `suffix.sty` file required by the acronym package.

### For Full TeX Live Users
All packages should be included. Verify with:
```bash
# Check if packages are available
tlmgr list --only-installed | grep -E "(biblatex|txfonts|acronym)"
```

## 6. Compilation Process

The IUBH template uses biblatex with biber backend, requiring a specific compilation sequence:

### Standard Compilation
```bash
# Navigate to template directory
cd LaTeX-IUBH-Template/

# Compilation with clean build directory
mkdir -p build
pdflatex -output-directory=build 00-Main.tex
biber --output-directory build 00-Main
pdflatex -output-directory=build 00-Main.tex
pdflatex -output-directory=build 00-Main.tex

```

### Build Directory
The template is configured to use a `build/` directory for all output files to keep the source directory clean:
- **PDF output**: `build/00-Main.pdf`
- **Log files**: `build/00-Main.log`, `build/00-Main.blg`
- **Auxiliary files**: `build/*.aux`, `build/*.toc`, `build/*.bbl`, etc.

## 7. Template Structure

### Main Files
- `00-Main.tex` - Main document with preamble and structure
- `biblio.bib` - Bibliography database
- `iubh.bst` - Custom IUBH bibliography style

### Content Files
- `001-Titlepage.tex` - University title page with logo
- `002-BlockingNotice.tex` - Blocking notice (optional)
- `003-Acknowledgements.tex` - Acknowledgements (optional)
- `004-Abstract.tex` - Abstract (optional)
- `005-Abbreviations.tex` - Acronyms and abbreviations
- `010-Intro.tex` - Introduction chapter
- `020-Body.tex` - Main content with examples
- `030-Conclusion.tex` - Conclusion chapter
- `041-Annexes.tex` - Appendices (optional)
- `042-Glossary.tex` - Glossary (optional)
- `070-Pledge.tex` - Academic integrity pledge

### Resources
- `pics/` - Directory containing logo.pdf and example graphics
- `LICENSE` - Apache 2.0 license
- `README.md` - Basic template information

## 8. Document Customization

### Personal Information
Edit `001-Titlepage.tex` to update:
- Student name and matriculation number
- Study program and semester
- Thesis/assignment title
- Advisor name
- Submission date

### Content Sections
Enable/disable sections by commenting/uncommenting include statements in `00-Main.tex`:

```latex
% Optional sections
%\include{002-BlockingNotice}
%\include{003-Acknowledgements}
%\include{004-Abstract}

% Main content
%\include{010-Intro}        % Enable as needed
\include{020-Body}          % Main content enabled
%\include{030-Conclusion}   % Enable as needed

% Optional appendices
%\include{041-Annexes}
%\include{042-Glossary}
```

### Bibliography Style
The template supports multiple bibliography approaches:
- **Modern (default)**: biblatex with APA style
- **Traditional**: BibTeX with custom iubh.bst style
- **Standard**: BibTeX with standard styles (alpha, plain, etc.)

## 9. Troubleshooting

### Common Issues

**Issue: chngcntr.sty not found**
```bash
sudo tlmgr install chngcntr
```

**Issue: scrhack.sty not found**
```bash
sudo tlmgr install scrhack
```

**Issue: txfonts.sty not found**
```bash
sudo tlmgr install txfonts
```

**Issue: biber not found**
```bash
sudo tlmgr install biber
```

**Issue: biblatex errors**
```bash
# Install biblatex and dependencies
sudo tlmgr install biblatex biblatex-apa csquotes logreq
```

**Issue: Logo not found**
Ensure `pics/logo.pdf` exists. If missing, comment out logo line in `001-Titlepage.tex`:
```latex
%\includegraphics[width=0.50\textwidth]{pics/logo.pdf}
```

**Issue: Bibliography not appearing**
1. Verify biber/bibtex runs without errors
2. Check that bibliography entries exist in `biblio.bib`
3. Ensure citations are used in text (e.g., `\textcite{DueckKo:2016}`)
4. Run complete compilation sequence

**Issue: Acronyms not working**
```bash
sudo tlmgr install acronym
```

**Issue: Float placement errors**
```bash
sudo tlmgr install placeins float
```

### Font Issues
If Times fonts (txfonts) cause problems:
```latex
% Comment out in 00-Main.tex
%\usepackage{txfonts}

% Use standard Computer Modern fonts instead
```

### Encoding Issues
Ensure your editor saves files in UTF-8 encoding to support international characters.

## 10. Editor Configuration

### VS Code with LaTeX Workshop
1. Install LaTeX Workshop extension
2. Configure `settings.json`:
```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": ["-interaction=nonstopmode", "%DOC%"]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": ["%DOCFILE%"]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex → biber → pdflatex × 2",
            "tools": ["pdflatex", "biber", "pdflatex", "pdflatex"]
        }
    ]
}
```

### TeXShop (macOS)
Configure TeXShop to use biber:
1. Preferences → Engine → BibTeX Engine: Set to `biber`
2. Use "Typeset" button for automatic compilation

### Command Line Workflow
Use the included build script:
```bash
# Make executable (one time only)
chmod +x build.sh

# Build the document
./build.sh
```

The build script automatically:
- Creates the `build/` directory
- Runs the complete compilation sequence
- Outputs `build/00-Main.pdf`
- Reports success and file size

## 11. Template Features

### Academic Formatting
- KOMA-Script document class for professional layout
- Proper page numbering (Roman for preliminaries, Arabic for content)
- Automatic table of contents, list of figures, and list of tables
- APA-style citations and bibliography
- Academic title page with university branding

### Advanced Features
- Acronym management with automatic expansion
- Cross-referencing for figures, tables, and equations
- Hyperlinked navigation throughout the document
- Vector graphics support (PDF, EPS)
- Code listing capabilities
- Float barriers for precise layout control

### Customization Options
- Multiple citation styles (APA, custom IUBH, standard)
- Flexible section inclusion/exclusion
- Support for multiple languages
- Customizable fonts and typography
- Configurable page layout and margins

## 12. Best Practices

### File Organization
- Keep content files separate from formatting
- Use meaningful labels for cross-references
- Organize images in the `pics/` directory
- Maintain bibliography in external `.bib` file

### Version Control
Add to `.gitignore`:
```
# Build directory (contains all output files)
build/

# LaTeX auxiliary files (if building in source directory)
*.aux
*.bbl
*.bcf
*.blg
*.fdb_latexmk
*.fls
*.log
*.out
*.run.xml
*.synctex.gz
*.toc
*.lof
*.lot
```

### Quality Assurance
- Always run spell check before final submission
- Verify all cross-references resolve correctly
- Check that all images display properly
- Validate bibliography entries
- Review PDF bookmarks and hyperlinks

## 13. Support and Resources

### Official Resources
- **Template Repository**: https://github.com/IUBH-IT-Technik-Profs-Sandbox/LaTeX-IUBH-Template
- **IUBH Guidelines**: Check university documentation for specific requirements

### LaTeX Documentation
- **KOMA-Script Manual**: http://mirrors.ctan.org/macros/latex/contrib/koma-script/doc/scrguien.pdf
- **Biblatex Manual**: http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf
- **LaTeX Wikibook**: https://en.wikibooks.org/wiki/LaTeX

### Package Documentation
Access package documentation with:
```bash
texdoc package-name
# Example: texdoc biblatex
```

### Getting Help
1. Check compilation logs (`.log` files) for error details
2. Search CTAN for package-specific documentation
3. Consult LaTeX community forums (TeX Stack Exchange)
4. Review university LaTeX guidelines and examples