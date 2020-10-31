build:
	python3 code_generator.py > example.ac
	lex lexic_analyzer.l 
	yacc -d semantics.y
	cc y.tab.c lex.yy.c -o syntax-calc

run:
	./syntax-calc example.ac

clean:
	rm -r *.ac *.yy.c *.tab.c *.tab.h syntax-calc