import std/strutils
import std/sets

var dnas: seq[string]
var current_dna = ""
var shortest_dna = ""

for line in "rosalind_lcsm.txt".readFile.strip.splitLines:
    var line2 = line.strip
    if line2.startsWith('>'):
        if current_dna.len != 0:
            dnas.add(current_dna)
            if shortest_dna.len == 0:
                shortest_dna = current_dna
            if shortest_dna.len > current_dna.len:
                shortest_dna = current_dna
            current_dna = ""
        continue
    current_dna &= line2
dnas.add(current_dna)
if shortest_dna.len > current_dna.len:
    shortest_dna = current_dna

# coded by gemini for this function
iterator get_all_substrings(str: string): string =
    var seen = initHashSet[string]()

    for size in countdown(str.len-1, 1):
        for i in 0 ..< str.len-size:
            var j = i + size
            var substr = str[i .. j]

            if substr notin seen:
                seen.incl(substr)
                yield substr

proc is_lcsm(substr: string): bool =
    for dna in dnas:
        if substr notin dna:
            return false
    return true

for substr in get_all_substrings(shortest_dna):
    if is_lcsm(substr):
        echo substr
        quit(0)