import std/strutils
import std/algorithm
import std/math

var N = "rosalind_sign.txt".readFile.strip.parseInt
var startSeq: seq[int]
for i in 0..<N:
    startSeq.add(i+1)

var toWrite = $(N.fac * (2^N)) & "\n"

var permutations = @[startSeq]
while startSeq.nextPermutation():
    permutations.add(startSeq)

proc applyMask(items: seq[int], n: int): string =
    for i, i1 in items:
        var sign = (-1)^((n shr i) mod 2)
        result &= $(sign * i1) & " "

for i in 0..<2^N:
    for perm in permutations:
        toWrite &= applyMask(perm, i) & "\n"

"rosalind_sign_output.txt".writeFile toWrite