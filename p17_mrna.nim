import std/strutils
import std/tables
import p08_translation

var codon_comb = Table[string, int]()
for (codon, monomer) in codon_table.pairs:
    if monomer notin codon_comb:
        codon_comb[monomer] = 0
    codon_comb[monomer].inc

var combination = 3 # 3 stop code
for monomer in "rosalind_mrna.txt".readFile.strip:
    combination = (combination * codon_comb[$monomer]) mod 1_000_000
echo combination