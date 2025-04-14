#import "@preview/algo:0.3.6": algo, i, d, comment, code
#import "@preview/showybox:2.0.4": showybox

#let question(num, stmt) = {
  showybox(
    [*#num* - #stmt]
  )
}

=== Page 29

#question("2.2-1", [Express the function $n^3/1000 - 100n^2 - 100n + 3$ in terms of $Theta$ notation.])
$Theta(n^3)$

#question("2.2-2'", [Write pseudocode for #smallcaps([Selection Sort]).])
#algo(title: "Selection Sort", parameters: ("A", ))[
  for cur = 0 to $A$.length:#i\
    small = $A$[cur]\
    index = cur\
    for k = cur + 1 to $A$.length:#i\
      if $A$[k] < small:#i\
        small = $A$[k]\
        index = k#d#d\
     temp = $A$[cur] #comment[Swap the values]\
     $A$[cur] = small\
     $A$[index] = temp\
]

=== Page 39

#question("2.3-3",
[Use mathematical induction to show that when $n$ is an exact power of 2, the solution of the recurrance
 $ T(n) = cases(2 &bold("if") n = 2, 2T(n/2)+n &bold("if") n = 2^k bold("for") k > 1)
 $
is $T(n) = n log_2 n$.])


We show that $T$ holds for $n = 2$

$ T(2) = 2 log_2 2 = 2 * 1 = 2
$

Assuming $T(n/2) = n/2 log_2 n/2$
$ T(n) &= 2(n/2 log_2 n/2) + n \
       &= 2(n/2 (log_2 n - log_2 2)) + n \
       &= 2(n/2 (log_2 n - 1)) + n \
       &= (n log_2 n - n) + n \
       &= n log_2 n
$



#pagebreak()
=== Undefined

Induction Theorem:
$ P(n_0) and (forall n_i > n+o . P(n_i) -> P(n_(i+1))) -> forall n > n_o P(n)
$

#question("1.1-1", [Use mathematical induction to show that $T(n) = (n^2+n)/2$ for
$ T(n) = cases(1 &bold("if") n = 1, T(n-1)+n &bold("if") n > 1)
$])

We show that $T$ holds for $n_0 = 1$
$ T(1) = (1^2 + 1)/2 = 2/2 =  1
$

#let c(c, x) = text(fill: c, $#x$)
#let cred(x) = c(red, x)
#let cblue(x) = c(blue,x)
Assuming $ T(n - 1) = ((n - 1)^2 +  (n - 1)) / 2$ and $n > 1$
$ T(n - 1) &= (cred((n - 1)^2) + cblue(n - 1)) / 2 \
           &= (cred(n^2 - 2n + 1) + cblue(n - 1)) / 2 \
           &= (n^2 - n) / 2 \
$

By the definition of $T(n)$

$ T(n) &= cred(T(n - 1)) + cblue(n) \
           &= cred((n^2 - n) / 2) + cblue(n) \
           &= (n^2 - n + cblue(2n)) / 2 \
           &= (n^2 + n) / 2
$

Therefore
$ T(n) = (n^2 + n) / 2
$

By the induction theorem:
$ T(n) = (n^2 + n) / 2 space forall n in NN, n != 0
$

$qed$
