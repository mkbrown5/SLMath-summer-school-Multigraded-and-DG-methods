-- Koszul duality has limited support in M2 currently
-- In this homework set, we'll develop some tools ourselves
-- compute some examples, and see some of the currently available tools

-- 1. There does not exist a function which checks if the resolution of k is linear up to degree n
-- Try making one: create a function "koszulUpToN":
-- Input: a ring R
-- Output: "true" if the res of k over R is linear up to degree n, "false" otherwise
-- Bonus points if your function correctly handles inhomogeneous rings

-- Some useful functions to consider:
viewHelp "res"
viewHelp "regularity"

-- 2. An ideal is G-quadratic if it has a quadratic Groebner basis with respect to some term order
-- Create a function which checks if an ideal is G-quadratic

-- Some useful functions to consider
flatten entries gens gb I -- computes the Groebner basis of I as a list 

-- 3. Recall that in an earlier problem session, we showed that a quadratic ideal with a linear resolution is Koszul
-- Write an algorithm "hasLinearRes"
-- Input: an ideal
-- Output: "true" if I has a linear resolution and "false" otherwise
-- Hint: Explain why, for a quadratic ideal
-- this property is equivalent to the regularity of R/I equaling 1

-- 4. A (pseudo)-random ideal can be generated using the following:
R = ZZ/101[x,y]
I = ideal(random(R^{2},R^3))
-- First number sets degrees, second the number of gens

-- 3.(a) is I Koszul? Is it G-quadratic?
-- Explain why any quadratic ideal in k[x,y] with three generators must be Koszul.
-- (in fact, one can prove that all quadratic ideals of k[x,y] are Koszul)

-- 3.(b) Repeat with R=k[x,y,z] and I a random quadratic ideal with 4 gens
-- hint: If nKoszul is taking too long, try reducing the characteristic
-- 3.(c) Repeat with R=k[w,x,y,z] and I with 5 gens

-- 4. We will consider a family of ideals I_n with nonlinearity first showing up in degree n+1
needsPackage "QuadraticIdealExamplesByRoos"
needsPackage "DGAlgebras"
n = 4
kk = ZZ/29
R = almostKoszul(kk,n)
-- You can peak at the ideal if you'd like
ideal R
-- 4.(a) Compute the Groebner basis of the defining ideal of R for a few values of n
-- Which cubic seems to consistently show up?

-- We will investigate the acyclic closure of the residue field of R
-- We will first need another tool:
-- 4.(b) Create a function "nonLinearVariables"
-- Input: a dg algebra R<T_1,...>
-- Output: Those T_i with internal degree greater than homological degree

-- Helpful functions
viewHelp select
-- degree(T_i) returns {i,j} where i is the homological degree and j is the internal degree
-- To get gens {T_1,...} of A=R<T_1,...> as a list, run "generators(A.natural)"

-- 4.(c) Compute the acyclic closure of k over R for a view different values of n
-- Nonlinearity starts at degree n, so run acyclicClosure(R,EndDegree=>n)
-- Use your function from 4.(b) to extract a nonlinear variable.  What is its differential?

-- 5. R^! can be computed by two packages, NCAlgebra and GradedLieAlgebras
-- NCAlgebra requires another computer algebra system "Bergman" which I found difficult to install
-- See my website for details
-- The GradedLieAlgebras package computes the homotopy Lie algebra, whose universal envelope is R^!

needsPackage "GradedLieAlgebras"
R = QQ[x,y]
E = koszulDual R
gens E
ideal E
-- bracketting is denoted by a space between variables
ko_0 ko_1
-- Parentheses are used for disambiguating (remember Lie algebras are NOT associative)
((ko_0 ko_0) ko_1)
-- We can see the whole ideal
ideal E
-- The universal envelope has its squares and anticommutator equal to zero
-- Hence this is the exterior algebra, as predicted by theory

-- Compute koszulDuals of the following, then compute their universal envelope by hand
R = QQ[x,y]/ideal(x^2,y^2)
R = QQ[x,y]/ideal(x^2,x*y)

-- What does koszulDual return when the algebra is not koszul?  Try computing koszulDual of the following:
R = QQ[x,y]/ideal(x^3,y^4)
-- verify that this is not Koszul by one of your functions above
R = QQ[x,y,z]/ideal(x^2,y^2+x*z,y*z)
