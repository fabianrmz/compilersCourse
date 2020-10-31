build:
	python3 code_generator.py > example.ac
	lex lexic_analyzer.l 
	yacc -d grammar.y
	cc y.tab.c lex.yy.c 

run:
	gcc lex.yy.c -ll

clean:
	rm -r *.ac *.yy.c