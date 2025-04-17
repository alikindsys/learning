#import "@preview/algo:0.3.6": algo, i, d, comment, code
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.3.4"

#let question(num, stmt) = {
  set enum(numbering: "A)")
  showybox(
    [*#num* - #stmt]
  )
}

#let hint(desc: "Hint", tip) = {
    showybox(
        frame:
        (body-color: blue.lighten(50%),
            radius:  0pt,
            thickness: (left: 1pt, right: 0pt, bottom: 0pt, top: 0pt)
        )
    )[#emoji.info *#desc*: #tip]
}

#show link: it => {
    set text(blue)
    underline(it)
}

=== Page 22

#question("2.1-3", [Consider the _*searching problem*_:

*Input:* A sequence of $n$ numbers $A = ⟨a_1,a_2,...,a_n⟩$ and a value $v$. \
*Output:* An index $i$ such that $v = A[i]$ or the special value #smallcaps("nil") if $v$ does not appear in $A$.

Write pseudocode for #smallcaps("Linear Search"), which scans the sequence, looking for $v$. Using a loop invariant, prove that your algorithm is correct. Make sure that your loop invariant fulfills the necessary three properties.
])

#hint(desc:"Loop Invariants")[Used for showing why an algorithm is correct. Has the following properties:\
    - *Initialization:* It is true prior to the first iteration of the loop.
    - *Maintenance:* If it is true before an iteration of the loop, it remains true before the next iteration.
    - *Termination:* When the loop terminates, the invariant gives us a useful property that helps show that the algorithm is correct.]<loop_invariant>

#algo(title: "Linear Search", parameters: ("A","v"))[
    for i = 0 to $A$.length:#i\
    if $A$[i] == $v$:#i\
    return cur#d#d\
    return #smallcaps("nil")
]

*Initialization:* The index is not found prior to the first iteration since nothing has been searched yet.\
*Maintenance:* At each step $i$ is incremented and $A[i]$ is checked against $v$ and the loop terminates if $v = A[i]$.\
*Termination:* The loop terminates when either $v$ is found, returning the index, or when all of $A$ is searched, returning #smallcaps("nil").\

=== Page 29

#question("2.2-1", [Express the function $n^3/1000 - 100n^2 - 100n + 3$ in terms of $Theta$ notation.])
$Theta(n^3)$

#question("2.2-2", [Consider sorting $n$ numbers stored in array $A$ by first finding the smallest element of $A$ and exchanging it with the element in $A[0]$. Then finding the second smallest element of $A$, and exchange it with $A[1]$. Continue in this manner for the first $n-1$ elements of $A$. This algorithm is known as #smallcaps([Selection Sort]).
    1. Write pseudocode for #smallcaps([Selection Sort]).
    2. What #link(label("loop_invariant"))[loop invariants] does this algorithm maintain?
    3. Why does it need to run for only the first $n-1$ elements, rather than for all $n$ elements?
    4. Give the best-case and worst-case running times of #smallcaps([Selection Sort]) in $Theta$-notation.])
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

Therefore $T(n) = n log_2 n$.

#question("2.3-4", [We can express insertion sort as a recursive procedure as follows. In order to sort $A[1..n]$, we recursively sort $A[1..n-1]$ and then insert $A[n]$ into the sorted array $A[1..n-1]$. Write a recurrance for the running time of this recursive version of insertion sort.])


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

#pagebreak()
#question("1.1-2",[Proof that $x*2=x+x$ using only the following identities:
    #set math.equation(numbering: "1.")

    $ 2 &= 1 - 1 $
    $ a * 1 &= a $
    $ a * b &= ( a * (b - 1)) + a $
])

$ x * 2 &= x + x \
<=> "(id 3)" \
(x * (2 - 1 )) + x &= x + x \
<=> "(id 1)"\
(x * 1) + x &= x + x \
<=> "(id 2)"\
x + x &= x + x
$

Tautology, therefore we're done. $qed$

#question("1.1-3", [Proof that $Delta A B C$ is congruent to $Delta C D E$ using the following identities:
    - If two triangles have two congruent angles and one congruent side in the same order relative to each other they are congruent. (Usuallt called "AAS Congruent").
    - When two straight lines cross, their opposite angles are congruent to each other.
    #set align(center)
    #cetz.canvas({
        import cetz.draw: *
        
        line((1,4),(3,5))
        
        set-style(content: (frame: "rect", stroke: none, padding: .1))
        
        content((0.8,4))[$A$]
        content((3.2,5.2))[$B$]
        content((3.2,3.2))[$C$]
        content((2.8,0.8))[$E$]
        content((5.2,2))[$D$]
    
        line((1,4), (5,2))
        line((5,2), (3,1))
        line((3,1), (3,3))

        line((3,3),(3,5))

        arc((3,5 - .3), start: 270deg, stop: 210deg, radius: 0.3, name: "^abc")
        arc((3, 1.3), start: 90deg, stop:30deg, radius: 0.3, name: "^ced")
        
        line((4.1,1.4) , (4, 1.6))
        line((2.1,4.4), (2, 4.6))
        
        line((3.2-.1, 1.3-.1), (3.35-.15, 1.45-.1))
        line((2.9,4.8), (2.75+.05,4.6+.05))
    })
])

When $accent("AD", -)$ crosses with $accent("BE", -)$ the following angles become congruent:

$ angle"ACB" tilde.equiv angle"DCE"\
angle"BCD" tilde.equiv angle"ACE"
$

For an Angle-Angle-Side congruent triangle we need 2 congruent angles and one congruent side.

$ accent("DE", -) tilde.equiv accent("AB", -) \
angle"CED" tilde.equiv angle"ABC"\
angle"ACB" tilde.equiv angle"DCE"
$

By AAS Congruency:
$ Delta"ABC" tilde.equiv Delta"CDE" $
#pagebreak()
#question("1.1-4", [Proof that the inversion of $not A and ((B < C) or D)$ is $A or ((B >=C) and not D)$.\ List all identities you used.])

Given the following identities:

#[
    #set math.equation(numbering: "(1)")
    #counter(math.equation).update(0)
    $ not (not A) = A $
    $ not (A and B) = not A or not B $
    $ not (A or B) = not A and not B $
    $ not (A < B) = A >= B $
]

We can proof

$ not (not A and ((B < C) or D)) &= A or ((B >= C) and not D)\
<=> "(id 2)"\
not (not A) or not((B < C) or D) &= A or ((B >= C) and not D)\
<=> "(id 1)"\
A or not((B < C) or D) &= A or ((B >= C) and not D) \
<=> "(id 3)"\
A or (not(B < C) and not D) &= A or ((B >= C) and not D) \
<=> "(id 4)" \
A or ((B >= C) and not D) &= A or ((B >= C) and not D)\
$

Tautology, therefore we're done. $qed$


// Local Variables:
// tp--master-file: "/home/alikindsys/Development/self/learning/algo/chapt2/answer.typ"
// End:
