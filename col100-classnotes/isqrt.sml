
fun isqrt(n) = 
	if (n=0) then 0
	else 
		let val r1 = 2* isqrt(n div 4) 
		in 
		let val r2 = r1 +1 
		in 
		if (r2*r2) <= n then r2
		else r1
		end
		end;

