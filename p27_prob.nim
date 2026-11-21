import std/strutils
import std/sequtils
import std/math

let content = "rosalind_prob.txt".readFile.strip.splitLines
let dna = content[0].strip
let raw_values = content[1].split(" ").mapIt(it.strip.parseFloat)

proc findProbabilityOfMatch(gcContent: float): float =
    var probG = gcContent/2
    var probA = (1 - gcContent)/2

    var probability = 1.0
    for nucleotide in dna:
        if nucleotide in ['G', 'C']:
            probability *= probG
        else:
            probability *= probA
    return probability

var to_write = ""
for value in raw_values:
    to_write &= $(log10(findProbabilityOfMatch(value)).formatFloat(ffDecimal, 3)) & " "
echo to_write