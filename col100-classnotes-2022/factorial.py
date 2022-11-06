# Add this to make it an executable script  #!/usr/local/bin/python3

def factorial(x): 
	if x ==1: 
		return 1
	else:
		return (x * factorial (x-1))

# a = 7
a = int (input ("Enter a positive integer:"))
result = factorial(a)
print("The factorial of ", a, " is ", result)
