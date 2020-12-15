fun empty([]) = true
   | empty (x::xs) = false;
     
fun singleton ls =
     if empty (ls) then false
     else empty(tl ls);

fun max a b =
    if a >= b then a
    else b;
    
fun maxL ls =
    if (singleton ls) then (hd ls)
    else max (hd ls) (maxL (tl ls));

fun lenL L =
    case L of  
       [] => 0 
      | x::xs => 1 + (lenL xs); 
fun appendL L M =
    case L of
      [] => M
    | x::xs => x:: (appendL xs M);

fun mapL f L =
    case L of
    	 [] => []
      |  x::xs => (f x)::(mapL f xs);

fun filterL f L =
    case L of
     	 [] => []
       | x::xs => if (f x) then x :: (filterL f xs)
       	          else (filterL f xs);

exception EmptyList
fun nth_element n [] = raise EmptyList
    | nth_element n (x::xs)   = if (n = 0) then x else (nth_element (n-1) xs);

fun reverseL L =
    case L of
       [] => []
     | (x::xs) => reverseL (xs) @ (x::[]); (* Time complexity T(n) = T(n-1) + n*)


(* Invariant: Let n be the length of input List L0. At ith step
     length (L) = n - i
     length (M) = i
     reverse(M)@L = L0
   Time Complexity: O(n), Space Complexity: O(n) 
*)
fun revIt (L) =
   let fun rev_iter (L, M) =
           case L of
    	   	 [] => M
		|(x::xs) => rev_iter (xs, (x::M))

   in
   rev_iter(L, [])
   end;


(* Inserting an element in a sorted list
fn: a x aLst-Sorted -> aLst-Sorted
Sorted -- ascending or descending order
Time Complexity
     Worst case: O(|L|)
     Best case: O(1)
     Average case: ?

Proof:
Base case: singleton list is sorted
I.H. for list of size >= 0 if you add a the output is
list with element a in sorted form.
I.S.: Invoke I.S. in the else part; in the then part
of the branch a < x  => a::L is sorted 
*)
fun insert ( a, []) = [a]
   | insert (a, x::xs) = if a < x then a::x::xs
     	    	         else x:: insert (a, xs)
                         
(* merging two sorted lists L1, L2
Time Complexity: O(|L1| + |L2|)
Proof by Induction:
Basis is straightforward
apply PMI v3:
   (xs, y::ys) < (x::xs, y::ys)
   Apply IH on merge (xs, y::ys)
   x < y and x < all x' in xs and
   y < all y' in ys implies that
   by transitivity x is less than
   all x' and y'. Hence x::merge(xs, y::ys) is
   also sorted.
   The other part can be done similarly
*)

fun merge ([], L2) = L2
   | merge (L1, []) = L1
   | merge (x::xs, y::ys) =
     	   if x <=y then x :: merge (xs, y::ys)
	   else y:: merge (x::xs, ys);
(*
Iterative Version of Merge function
Invariant: ?
Time Complexity: ?
PMI proof: ?
*)
fun merge1 (L1, L2) =
      let
	fun merge_it (a, b, c) =
	    if (a = []) then c@b
	    else if (b = []) then c@a
	    	 else
		    let val x::xs = a
		    	val y::ys = b
		    in
		    if (x <= y) then merge_it(xs, y::ys, c@[x])
		    else merge_it(x::xs, ys, c@[y])
		    end
      in
      merge_it (L1, L2, [])
      end;

(*Insertion Sort
: Is really reduced to the problem
of inserting the head of the list
at the right position in the list
recursively
*)
(*
fn: aList -> aListSorted
Time Complexity:
   Worst case:T(n) = T(n-1) + n; T(0) = 0;
   	      T(n) = O(n^2)
   Best case: O(n) when the list is already sorted      
PMI proof:
Base case is trivial
IS - inSort (xs) is true by IH
     x < all x' in xs =>
     insert(x, ..) is also sorted
*)
fun inSort (ls) =
    case ls of
    	 [] => []
	|x::xs => insert (x, inSort (xs));  

(* iterative version of Insertion sort *)
(*
Time complexity:?
Invariant: length (ls) = n - i,
length (res) = i , res has all i elements
of ls0 in sorted order, ls contains the last
n-i elements
Proof: 
*)
fun inSort1 (ls) =
    let
	fun inSort_iter (L, res) =
	    case L of
	    	 [] => res
		|x::xs => inSort_iter(xs, insert(x,res))
    in
    inSort_iter (ls, [])
    end;

(*merge sort*)
(*
use ideas of divide and conquer, i.e. n div 2 sized lists
use merge in O(n+m)
*)

(*
Helper function
Purpose: for all l, there exist (p1,p2) such that
split l == (p1,p2) where p1@p2 is a permutation of l and
the sizes of p1 and p2 differ by no more than one.
Question: Why do we need the case [x]=> ([x], [])
Answer:      mergesort [2,1]
|->* merge (mergesort [2] , mergesort [1])
|->* merge (merge (mergesort[2] , mergesort []) , mergesort [1])
|->* merge (merge (merge (mergesort[2] , mergesort []) , mergesort []) , mergesort [1])
|->* ...
Ooops! It’s an infinite loop!
Time complexity: O(n)
*)
fun split (ls) =
    case ls of
    	 [] => ([], [])
	| [x] => ([x],[])
	| x::y::xs =>
	  	   let val (p1, p2) = split (xs) in
		   (x::p1, y::p2)   
		   end;
(*
Time Compexity:
     n		n merge op
 n/2   n/2      n   " 
n/4 n/4 ...     n   "

Eg: sort [3,1,4,2]
 sort[3,1]   sort [4,2]
sort[3] sort[1] sort[4] sort[2]
      [1,3]      [2,4]
          [1,2,3,4]  
How many steps: log(n)

Recurrence relation:
T(n) = 2 T(n/2) + 2.n (merge+ split = 2.n)
     ...
     = 2^k T(0) + 2.k.(2^k) (where n = 2^k)
     = n + n log(n) =  O(n*log(n))
 *)
(*
PMI proof:
1. [] is sorted
2. x::xs is sorted if xs is sorted and x < x' forall x' in xs
3. if x is sorted then xs is also sorted
(conditions 2 and 3 give the iff condition)
I. Base case is trivial
II. split ls returns smaller lists l1 and l2
III. I.H. tells us that l1 and l2 are sorted
IV. merge produces the sorted list when given two sorted lists (earlier proof).
Proof is not complete -- you will have to provide inductive
arguments that split produces a list which is not only smaller but
is obtained by *only* deleting one of more elements from L
*)

fun msort (ls) =
    case ls of
    	[] => []    (* split on singleton is not necessarily smaller; however, it is smaller for all n>=2 *)
      | [x] => [x]
      | _ => 
      	     let
	     	val (l1, l2) = split (ls)
    	     in
	         merge (msort (l1), msort(l2))
    	     end;

(* trivia: if you have to sort say  billion entries [something like Aadhaar]
insertion sort will take 10^18 steps. Imagine a single step takes 10^-9seconds.
then we have 10^9 seconds ~32 years! But if we solve it by
merge sort then it will take ~ 3 seconds.)
*)


(* Quick Sort *)
(*
* Find a partition "x" s.t. we have a list 
* [ all x'<=x, x, all x' > x] 
* We can start with the head of the list and let that be x 
*)

fun compare oper x y = oper(y,x):bool;

fun qsort ([]) = []
  | qsort (x::xs) =
     qsort( filterL (compare op<= x) xs) @ [x] @ qsort(filterL (compare op> x) xs)



fun  partition (pivot, []) = ([], [])
    |partition (pivot, x::xs) =
    	       let
		  val (lesser, bigger) = partition (pivot, xs)
	       in
	          if x < pivot then (x::lesser, bigger)
		  else (lesser, x::bigger)
		end;
		  
fun qsort1([]) = []
   |qsort1([x]) = [x]
   | qsort1(x::xs) =
       let
	  val (lesser, bigger) = partition(x,xs)
       in
	  qsort(lesser) @ [x] @ qsort(bigger)
       end;  