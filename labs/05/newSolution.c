#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


/***************************
Grammar:
E -> T | T  + E
T -> int | int * T| ( E )
***************************/

char l;

bool E_1();
bool E_2();
bool E();

bool T_1();
bool T_2();
bool T_3();
bool T_4();
bool T();

void error(){
	printf("Error\n");
	exit(-1);
}

// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else
        
		error();
}



// Definition of E, as per the given production
bool E() {
    if(E_1()){
        if(l=='+'){
            if(E_2()){
                return true;
            }else{
                return false;
            }
        }
        return true;
	}else{
		error();
	}
}

bool E_1(){
    if(T()){
        return true;
    }else
    {
        return false;
    }
    
}



bool E_2(){
    if(match('+') && E()){
	    return true;
    }else{
		return false;
	}
}
bool T_1(){
    if(match('(') && E() && match(')')){
        return true;
    }else{
        return false;
    }
}

bool T_2(){
    if(match('i') && match('n') && match('t')){
        return true;
    }else{
        return false;
    }
}

bool T_3(){
    if(match('*') && T()){
        return true;
    }else{
        return false;
    }
}


bool T(){
    if(l=='('){
        if(T_1()){
            return true;
        }else{
            return false;
        }
        
    }else if(l=='i'){
        if(T_2()){
            if(l=='*'){
                if(T_3()){
                    return true;
                }else{
                    return false;
                }
            }
            return true;
        }else{
            return false;
        }
    }else{
		error();
	}
}

int main() {
    do {
        l = getchar();
		// E is a start symbol.
	    E();
    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}