import std/strutils
import std/sequtils
import bigints

let content = "rosalind_pmch.txt".readFile.strip.splitLines
let rna = content[1 .. ^1].mapIt(it.strip).join("")

proc fact(n: int): BigInt =
    result = 1.initBigint
    for i in 2..n:
        result *= i.initBigint

"rosalind_pmch_output.txt".writeFile($(  rna.count('A').fact * rna.count('G').fact))