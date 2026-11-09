import std/strutils
import std/algorithm
import std/math

var count = "rosalind_perm.txt".readFile.strip.parseInt
var permutation = newSeq[int](count)
for i in 0..<count:
    permutation[i] = i+1

proc display_current() =
    var to_echo = ""
    for item in permutation:
        to_echo &= $item & " "
    echo to_echo

echo fac(count)
display_current()

while nextPermutation(permutation):
    display_current()