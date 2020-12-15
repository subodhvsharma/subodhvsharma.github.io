"""
swap (a, b) 
 PRECONDITION: assert: a == a0 /\ b == b0
    temp = a
    a = b
    b = temp

 POSTCONDITION: assert: a == b0 /\ b == a0
"""
def swap (a, b):
    if  a>b: 
        temp = a
        a = b
        b = temp 
        #assert (a== b0) and (b ==a0)
    elif a ==b :
        print( "SWAP conditions not met")
    else :
        print( "SWAP conditions not met")

swap(5,6)

"""
LOOP INVARIANTS: assert(A) 
while(C): 
    assert(A /\ C) 
    {
    S
    } 
assert(A /\ ~C)

assert(A) 
if (C1): assert(A /\ C) 
else: assert(A /\ ~C)

s1
s2

asdsada

"""
# assert: a == a0 /\ b == b0
def newfn (a, b):
    a = a+b
    # assert: a ==  a0 + b0 /\ b == b0
    b = a - b
    # assert: a == a0 + b0 /\ b == a0
    a = a - b
    # assert: a == b0 /\ b == a0


"""
fun fact_iter (n, f, c) = 
   if (c = n) then f else fact_iter (n, f*(c+1), c+1)
"""
def fact_iter (n):
    f = 1
    c = 0
    #assert (0 <= c <= n) and (f =  c!)
    while (c !=n):
        c = c+1
        f = f*c
    #print("the value of f is %d",f)
    return f

"""
1. Arrays: that hold items of the same type
2. a[SIZE][SIZE]: multidimensional
3. the size of the arrays have to be known apriori
"""
insertion sort 
