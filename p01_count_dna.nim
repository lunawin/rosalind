import std/strutils
import std/strformat

var content = readFile("rosalind_dna.txt")

var count_A = content.count("A")
var count_C = content.count("C")
var count_G = content.count("G")
var count_T = content.count("T")

echo fmt"{count_A} {count_C} {count_G} {count_T}"