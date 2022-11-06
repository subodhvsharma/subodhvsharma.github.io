def square(n):
    return n*n

def sum_of_squares(x,y):
    return square(x) + square(y)

# N x N -> N 
def max(a,b):
    if a >= b:
        return a
    else:
        return b

def min(a,b):
    if a <= b:
        return a
    else:
        return b

def gcd(a,b):
    m = max(a,b)
    n = min(a,b)
    if (a == 0) or (b == 0) or (m ==n):
        return m 
    else:
        gcd(m-n, n)
