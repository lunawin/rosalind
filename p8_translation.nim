import std/strutils
import std/tables

var codon_table_str = """
UUU F      CUU L      AUU I      GUU V
UUC F      CUC L      AUC I      GUC V
UUA L      CUA L      AUA I      GUA V
UUG L      CUG L      AUG M      GUG V
UCU S      CCU P      ACU T      GCU A
UCC S      CCC P      ACC T      GCC A
UCA S      CCA P      ACA T      GCA A
UCG S      CCG P      ACG T      GCG A
UAU Y      CAU H      AAU N      GAU D
UAC Y      CAC H      AAC N      GAC D
UAA Stop   CAA Q      AAA K      GAA E
UAG Stop   CAG Q      AAG K      GAG E
UGU C      CGU R      AGU S      GGU G
UGC C      CGC R      AGC S      GGC G
UGA Stop   CGA R      AGA R      GGA G
UGG W      CGG R      AGG R      GGG G 
""".strip

var codon_table = Table[string, string]()
var stop_codons: seq[string]
for line in codon_table_str.splitLines:
    var raw_splt = line.splitWhitespace()
    for index in 0..<(raw_splt.len div 2):
        var codon = raw_splt[2 * index + 0]
        var value = raw_splt[2 * index + 1]
        if value != "Stop":
            codon_table[codon] = value
        else:
            stop_codons.add(codon)

##############################################

var content = readFile("rosalind_prot.txt").strip

var translation_result = ""
for i in countup(0, content.len, 3):
    var codon = content[i ..< (i+3)]
    if codon in stop_codons:
        break
    translation_result.add codon_table[codon]
echo translation_result