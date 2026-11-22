import std/strutils

var dnas: seq[string] = @[]
for line in "rosalind_tran.txt".readFile.strip.splitLines:
    if line.startsWith('>'):
        dnas.add("")
    else:
        dnas[^1] &= line.strip

var s1 = dnas[0]
var s2 = dnas[1]

var transitions = [('A', 'G'), ('G', 'A'), ('C', 'T'), ('T', 'C')]
var transversions = [('A', 'C'), ('C', 'A'), ('G', 'T'), ('T', 'G'), ('A', 'T'), ('T', 'A'), ('C', 'G'), ('G', 'C')]

var transitionCount = 0
var transversionCount = 0

for i, n1 in s1:
    var n2 = s2[i]
    if n1 == n2:
        continue
    elif (n1, n2) in transitions:
        transitionCount.inc
    else:
        transversionCount.inc

echo transitionCount/transversionCount