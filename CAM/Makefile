# To generate the turnin, type "make all".
# To run other commands type "make <command>". I.E. "make turnin".
# To remove the executeable and any extraneous files type "make clean" at 
# the command prompt.
###############################################################################
#Variable to hold lab number
LABNUM=6

#Variable to hold first lastname
LASTNAME1=Kurukulasooriya

#Variable to hold second lastname
LASTNAME2=Lee

#Variable of Tarball generated
TAR=lab$(LABNUM)_$(LASTNAME1)_$(LASTNAME2).tgz

#Variable of Post Script generated
PSPRINT=lab$(LABNUM)_$(LASTNAME1)_$(LASTNAME2).ps
PDFPRINT=lab$(LABNUM)_$(LASTNAME1)_$(LASTNAME2).pdf

#File hiearachy is lab$(LABNUM)_$(PART)$(SUBPART)$(TESTBENCH).$(EXTENSION)
#$(LABNUM)= lab number
#$(PART)= if a lab part exists in order from 1 to infinity
#$(SUBPART)= if other components were used to make this component that were 
#            not included then put them here in order from a to z. If "a" 
#            requires sub parts then put "a"$(subsubpart) I.E. "a1" now 
#            numbering. Continue letter/number trend to infinity.
#$(TESTBENCH)= if this is a test bench file then put "tb" to indicate it 
#              is test bench for this part
#$(EXTENSION)= is the character file extension

#Files to be included in the PS/PDF print
FILES=CAM_Array.vhd CAM_Cell.vhd CAM_Row.vhd CAM_Wrapper.vhd lab6_Lee_Kurukulasooriya_report.pdf lab6_Lee_Kurukulasooriya_report.doc lab6_Lee_Kurukulasooriya_report.xls lab6_Kurukulasooriya_Lee.ps Makefile

#Variable of to use G++ GNU compiler to compile C files
COMPILER=gcc

# -g Produce debug information, necessary for debugging. 
# -Wall 	Show all reasonable warnings...
# -Werror Make all warnings into errors.
# -ansi This flag tells the compiler to enforce ANSI C standards 
# -pedantic More pedantic ansi, warnings for stuff you probably didn't mean. 
# -O2 Optimize even more. GCC performs nearly all supported optimizations that
#  do not involve a space-speed tradeoff. As compared to -O, this option 
#	increases both compilation time and the performance of the generated code.
# -O3 Optimize yet more. -O3 turns on all optimizations specified by -O2 
#  and also turns on the -finline-functions, -funswitch-loops, 
#  -fpredictive-commoning, -fgcse-after-reload, -ftree-vectorize and 
#  -fipa-cp-clone options.

#Variable of GCC Compiler flags
COMPILEFLAGS= -g -Wall -Werror -ansi -pedantic -O3

#Variable of Program name
PROGRAM=genvhdl

#Targets
#Compile all, specifically first clean, print,
# turnin, and compile in this order
all: clean print turnin

#Compile C code
compile:
	$(COMPILER) $(COMPILEFLAGS) -o $(PROGRAM) gen.c

#Remove unnecessary files
clean:
	rm -rf *~ $(PSPRINT) $(PDFPRINT) $(TAR) $(PROGRAM)

#Print files to a .ps document
print:
	a2ps -M letter --line-numbers=1 -o $(PSPRINT) $(FILES)

printpdf:
	enscript -2 --fancy-header --line-numbers=1 --truncate-lines \
	--word-wrap --style=emacs --tabsize=3 --landscape $(FILES) \
	-o - | ps2pdfwr - $(PDFPRINT)

#Create a tar ball for project turn in
turnin:
	tar -czvf $(TAR) $(PSPRINT) $(FILES)

