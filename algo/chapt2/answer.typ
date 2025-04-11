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
