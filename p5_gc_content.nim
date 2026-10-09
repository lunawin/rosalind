import std/strutils
import std/strformat
import std/tables
import std/math

var dna_database = newTable[string, tuple[dna: string, gc_content: float]]()
var content = readFile("rosalind_gc.txt").strip()

var current_name = ""
var current_dna = ""
for line in content.splitLines():
    if line[0] == '>':
        if current_name.len != 0:
            dna_database[current_name] = (dna: current_dna, gc_content: 0.0)
            current_name = ""
            current_dna = ""
        current_name = line[1..^1]
        continue
    current_dna &= line
dna_database[current_name] = (dna: current_dna, gc_content: 0.0)

var current_highest_name = ""
var current_highest_content = 0.0
for name, info in dna_database.pairs:
    var gc_total = info.dna.count('G') + info.dna.count('C')
    var gc_content = round(gc_total.toFloat / info.dna.len.toFloat*100, 6)
    var val = (dna: info.dna, gc_content: gc_content)
    dna_database[name] = val

    if gc_content > current_highest_content:
        current_highest_content = gc_content
        current_highest_name = name

for name, info in dna_database.pairs:
    echo fmt"{name} has GC content of {info.gc_content}%"
echo fmt"DNA with highest GC content is {current_highest_name} with {current_highest_content}%"
echo fmt"{current_highest_name}"
echo fmt"{current_highest_content}"