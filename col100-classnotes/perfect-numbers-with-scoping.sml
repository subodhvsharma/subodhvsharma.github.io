exception NonPositive
fun perfect (n) = 
	if (n <= 0) then raise NonPositive
	else 
	    let fun sum_divisors(l, u) = 
			if (l > u) then 0 
			else 
			    let fun ifdivisor(k) = 
					if (n mod k = 0) then k
					else 0 
			    in
			    ifdivisor(l) + sum_divisors(l+1, u)
			    end	
	     in
	     n = sum_divisors(1, n div 2)
             end;
