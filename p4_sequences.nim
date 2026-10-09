import std/strutils

var content = readFile("rosalind_fib.txt").strip()
echo content

var data = content.split(" ")
var n = data[0].parseInt
var k = data[1].parseInt

var adults = 0
var babies = 1

for _ in 1..<n:
    var new_babies = adults * k
    adults += babies
    babies = new_babies

echo adults + babies