import std/strutils

var content = readFile("rosalind_subs.txt").strip.splitLines

var dna = content[0].strip
var substr = content[1].strip

var result = ""
var start = 0
while true:
    var index = dna.find(substr, start)+1
    if index == 0:
        break
    result &= $index & " "
    start = index
echo result