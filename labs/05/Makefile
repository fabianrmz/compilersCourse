all:
	yacc -d simplecalc.y
	lex simplecalc.l
	cc y.tab.c lex.yy.c -o simplecalc
	./simplecalc

clean:
	rm -rf simplecalc
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch