import std/strutils

let content = "rosalind_pper.txt".readFile.strip.split(" ")
var n = content[0].parseInt
var k = content[1].parseInt

var permutations = 1

for i in 0..<k:
    permutations = (permutations * (n - i)) mod 1_000_000
echo permutations