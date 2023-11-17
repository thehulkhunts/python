import sys

def add(a, b):
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

num1 = float(sys.argv[1]) #accepts command line args and store in variable 
operation = sys.argv[2]
num2 = float(sys.argv[3])

if operation == "add":
    output = add(num1, num2)
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

