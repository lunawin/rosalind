import std/strutils

let content = "rosalind_lexf.txt".readFile.strip.splitLines
let alphabet = content[0].strip.split(" ")
let n = content[1].strip.parseInt

var current_listing = alphabet
var new_listing: seq[string]
for _ in 0..<n-1:
    for character in alphabet:
        for item in current_listing:
            new_listing.add(character & item)
    # TIL: move is more efficient
    current_listing = move(new_listing)

"rosalind_lexf_output.txt".writeFile current_listing.join("\n")