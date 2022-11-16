def SimplePow(x, n):
    if n == 0:
        return 1
    else:
        return x*SimplePow(x, n-1)

def FastPow(x, n):
    if n == 0:
        return 1
    elif (n%2 == 0):
        return FastPow(x*x, n//2)
    else:
        return x*FastPow(x*x, n//2)


x = int(input("enter x: "))
n = int(input("enter n: "))

print("Simple Power of x^n:",SimplePow(x,n))
print("Fast Power of x^n:",FastPow(x,n))
