signature MyRational =
	  sig
	  type number;
	  val makerat: int * int -> number;
	  val plus: number * number -> number;
	  end;

structure RAT1: MyRational =
	  struct
	   datatype number = ratify of int*int;
	   fun gcd (a, b) = if b = 0 then a else gcd (b, a mod b);
	   exception DenomIsZero;
	   fun makerat (p: int, q: int): number =
	       if (q = 0) then raise DenomIsZero
	       else
		let
	           val posp = abs(p);
		   val posq = abs(q);
		   val sign = if (p = 0) then 0
		       	      else (p div posp)*(q div posq);
		   val g = gcd (posp, posq);
		in
		   ratify (sign * (posp div g), posq div g)
		end;
	    fun numer (ratify(x,_)) = x;
	    fun denom (ratify(_,y)) = y;
	    fun plus (a, b) =
	    	let val x = numer(a)*denom(b) + numer(b) *denom(a);
		    val y = denom(a)*denom(b);
		in
		make`rat(x,y)
		end;
	    end;