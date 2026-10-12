import std/strutils

var content = readFile("rosalind_hamm.txt").splitLines()
var dna_1 = content[0]
var dna_2 = content[1]

if dna_1.len != dna_2.len:
    raise ValueError.newException("DNA length is not same.")

var mutations = 0
for i in 0..<dna_1.len:
    if dna_1[i] != dna_2[i]:
        mutations.inc

echo mutations