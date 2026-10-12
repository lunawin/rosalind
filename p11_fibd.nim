import std/math
import std/strutils
import bigints

var content = readFile("rosalind_fibd.txt").strip.split
var n = content[0].parseInt
var m = content[1].parseInt

var rabbit_pairs = newSeq[BigInt](m)
rabbit_pairs[0] = initBigInt(1)

for _ in 0..<(n-1):
    var new_pairs = initBigInt(0)
    for i in 1..<m:
        new_pairs += rabbit_pairs[i]
    
    for i in countdown(m-2, 0):
        rabbit_pairs[i+1] = rabbit_pairs[i]
    rabbit_pairs[0] = new_pairs
    echo rabbit_pairs

echo rabbit_pairs.sum