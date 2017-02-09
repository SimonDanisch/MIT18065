1. We reccomend use of Jupyter notebooks
  * You can log into [juliabox](http://www.juliabox.org) and avoid installation, but many students like having a local version of Julia.
  * If you have jupyter installed, you can open a new notebook by typing in the REPL (the Julia terminal) <br>
     `using IJulia` <br>
     `notebook()`
1. Opening a notebook
  * From the dashboard, click NEW in the upper right, and Julia 0.5.0
  * Type 1+1 <shift+enter> and away you go.
2. Some useful Julia ideas:
  * Matrix indices are 1 based: A[1,1] is the upper left entry of A.
  * A = randn(m,n) is a random m x n matrix of standard normals
  * A = randn(n) is a random n vector of standard normals (this is a one dimensional structure)
  * length(A) is the number of elements in A
  * `A=[ i+j  for i=1:5,j=1:5]`  Creates a 5x5 matrix.  This construction is called a "comprehension".
  * `1:5` is called a range.  It may or may not behave like the vector `[1,2,3,4,5]`, but `[1:5;]` is the vector.
  * One could have also typed the longer form `[i for i=1:5]`.
  * A function that computes M*x+b:
  ```
  function myfunction(x,M,b)
      M*x+b
  end
  ```
  * A short form for that same function:
  `myfunction2(x,M,B) = M*x+b`
  * A longer form for that same function:
  ```
  function myfunction3(x,M,b)
     n = length(x) # assume x and b are length n, and M is nxn
     z = copy(b)   # make a copy of b
     for i=1:n, j=1:n
       z[i] += M[i,j]*x[j]
     end
     z
  end
  ```
  * A basic if statement to pick the larger of x or y:
  ```
  if x>y
     y
  else
     x
  end
  ```
  Same thing, in compact ternary format:
  ```
  x>y ? x : y
  ```
    
      
  * Julia cheatsheets:
     * https://math.mit.edu/~stevenj/Julia-cheatsheet.pdf  (assumes PyPlot installed)
     * https://cheatsheets.quantecon.org/
 
  
