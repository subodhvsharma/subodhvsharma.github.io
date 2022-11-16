def Fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return Fib(n-1) + Fib(n-2)

def FibTR(n, a, b):
    if n == 0:
        return a
    elif n == 1:
        return b
    else:
        return FibTR(n-1, b, a+b)

def newFib(n):
    return FibTR(n, 0, 1)

n = int(input("Enter a number (> 0): "))
print("Simple Fib(n): ", Fib(n))
print ("TR Fib(n): ", newFib(n))
    
