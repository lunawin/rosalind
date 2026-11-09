import std/strutils
import std/tables
import p08_translation

var dnaseq = ""
for line in "rosalind_orf.txt".readFile.strip.splitLines:
    if line.startsWith('>'): continue
    dnaseq &= line.strip

var main_rna = dnaseq.replace('T', 'U')
var start_codon = "AUG"

const complements = {
    'A': 'U',
    'U': 'A',
    'G': 'C',
    'C': 'G'
}.toTable

proc reverse_complement(rnaseq: string): string =
    for i in countdown(rnaseq.len-1, 0):
        result.add(complements[rnaseq[i]])

proc find_valid_coding_rna(rnaseq: string, start: int): string =
    var start_indx = rnaseq.find(start_codon, start)
    if start_indx == -1:
        return ""

    var stop_indx = rnaseq.len

    for stop_codon in stop_codons:
        block check_codon:
            var stop_codon_start = start_indx
            var indx = 0
            
            while true:
                indx = rnaseq.find(stop_codon, stop_codon_start)
                if indx == -1:
                    break check_codon
                if (indx - start_indx) mod 3 == 0:
                    break
                else:
                    stop_codon_start = indx+1
        
            if indx < stop_indx:
                stop_indx = indx

    if stop_indx == rnaseq.len: return ""
    return rnaseq[start_indx ..< (stop_indx+3)]

proc find_valid_proteins(rna: string): seq[string] =
    var start = 0
    while true:
        var coding_rna = find_valid_coding_rna(rna, start)
        if coding_rna.len == 0:
            return
        start = rna.find(start_codon, start+1)
        result.add(coding_rna.translate)

var to_ignore: seq[string]
for rna in [main_rna, main_rna.reverse_complement]:
    for protein in find_valid_proteins(rna):
        if protein notin to_ignore:
            to_ignore.add protein
            echo protein