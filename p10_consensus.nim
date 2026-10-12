import std/strutils
import std/strformat
import std/enumerate
import std/tables

var content = readFile("rosalind_cons.txt").strip
var dna_seqs: seq[string]
var base_table  = {'A': 0, 'C': 1, 'G': 2, 'T': 3}.toTable
var rbase_table = {0: 'A', 1: 'C', 2: 'G', 3: 'T'}.toTable


var curr_seq = ""
for line in content.splitLines:
    if line.startsWith('>'):
        if curr_seq.len != 0:
            dna_seqs.add(curr_seq)
            curr_seq = ""
        continue
    curr_seq &= line
dna_seqs.add(curr_seq)

var seqlen = dna_seqs[0].len
var profile = newSeq[int](4 * seqlen)
var raw_consensus: seq[seq[char]] = @[]

for i in 0..<seqlen:
    var counts = @[0, 0, 0, 0]
    for dna in dna_seqs:
        var base = dna[i]
        counts[base_table[base]].inc
    for i2 in 0..<4:
        profile[i2 * seqlen + i] = counts[i2]
    var cons: seq[char] = @[]
    var max = counts.max
    for indx, count in enumerate(counts):
        if count == max:
            cons.add(rbase_table[indx]) 
    raw_consensus.add(cons)

var consensus = ""
for i in 0..<raw_consensus.len:
    consensus &= raw_consensus[i][0]
echo consensus

for i, letter in enumerate(@['A', 'C', 'G', 'T']):
    var to_echo = fmt"{letter}: "
    for indx in (i * seqlen) ..< ((i+1) * seqlen):
        to_echo &= $profile[indx] & " "
    echo to_echo