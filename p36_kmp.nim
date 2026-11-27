import std/strutils

var dna = ""
for line in "rosalind_kmp.txt".readFile.strip.splitLines:
    if line.startsWith('>'):
        continue
    dna &= line.strip

var failure_array = newSeq[int](dna.len)

# entirely AI. i have given up.
proc assign_values() =
    var j = 0
    for k in 1..<dna.len:
        while j > 0 and dna[k] != dna[j]:
            j = failure_array[j - 1]
        if dna[k] == dna[j]:
            j += 1
        failure_array[k] = j

assign_values()
var to_write = ""
for item in failure_array:
    to_write &= $item & " "
echo to_write