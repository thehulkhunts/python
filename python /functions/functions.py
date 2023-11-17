import sys

def add(a, b):  # function accepts args 
    c = a+b
    return c

def sub(a, b):
    c = a-b
    return c

def mul(a, b):
    c = a*b
    return c

def div(a, b):
    c = a/b
    return c

num1 = float(sys.argv[1]) #accepts command line args and store in variable num1 
operation = sys.argv[2]   #operation is a variable store the operation that we perform at cli
num2 = float(sys.argv[3])  #num2 is a variable store arg3

if operation == "add":   #checks with cli args if matches prints output
    output = add(num1, num2)  # calling add function with args 
    print(output)

if operation == "sub":
    output = sub(num1, num2)
    print(output)

if operation == "mul":
    output = mul(num1, num2)
    print(output)

if operation == "div":
    output = div(num1, num2)
    print(output)

