import std/strutils
import std/algorithm

var dna = ""
for line in "rosalind_kmer.txt".readFile.strip.splitLines:
    if line.startsWith('>'): continue
    dna &= line.strip

var bases = @["A", "C", "G", "T"]
bases.sort()
var windows: seq[string] = bases
var new_window: seq[string]

for _ in 0..<3:
    for base in bases:
        for window in windows:
            new_window.add(base & window)
    windows = new_window
    new_window = @[]

var to_write = ""
for window in windows:
    to_write &= $(dna.count(window, overlapping=true)) & " "
echo to_write