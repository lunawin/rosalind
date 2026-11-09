import std/strutils
import std/tables

var dna = ""
for line in "rosalind_revp.txt".readFile.strip.splitLines:
    if line.startsWith('>'): continue
    dna &= line.strip

const complements = {
    'A': 'T',
    'T': 'A',
    'G': 'C',
    'C': 'G'
}.toTable

proc reverse_complement(dnaseq: string): string =
    for i in countdown(dnaseq.len-1, 0):
        result.add(complements[dnaseq[i]])

proc find_reverse_palindromes(window_size: int): seq[int] =
    for i in 0 .. (dna.len-window_size):
        var chunk = dna[i ..< (i + window_size)]
        if chunk == reverse_complement(chunk):
            result.add(i+1)

for l in 4..12: # TODO: valid reverse-complements can only be even, but im lazy
    var palindromes = find_reverse_palindromes(l)
    for palindrome in palindromes:
        echo palindrome, " ", l