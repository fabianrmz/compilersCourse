import sys
import re
#Fabian Ramirez

#A01630024

def main():
    print("File "+sys.argv[0])
    print("Hi, this is the output of the analysis: ")
    line =""
    functions = {}
    instructions = {}
    count=0
    for x in sys.argv[1] :
        
        if x=="\n" or count==9919:
            if re.search("([0-9a-z]{16})", str(line)) and len(line.split(" "))==2: #validate is function?
                function = line.split(" ")[1]
                function = function.replace(":", "").replace("_", " ").replace("__", "").replace("<", "").replace(">", "")
                functions[function]=line.split(" ")[0]
                
            elif re.search("([0-9a-z]{4}):", str(line)) and len(line.split("\t"))>2:  #validate is instruction
                instruction= (((line.split("\t")[2]).split(" ")[0]))
                
                try:
                    instructions[str(instruction)]+=1
                except:
                    
                    instructions[instruction]=1
            line=""
        else:
            line+=x
        count+=1

    # P R I N T I N G     Z O N E
    print()
    print("\tYou have ", len(instructions), " kind of instructions in this object file: ")
    for n in instructions:
        print("\t •", n,": Executed", instructions[n],"times")
    print()
    print("\tYou have ", len(functions), " functions: ")
    for n in functions:
        print("\t •", n,": Located at", functions[n])
        
main()
