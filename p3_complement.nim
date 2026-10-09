import std/strutils
import std/algorithm

var content = readFile("rosalind_revc.txt")
content.reverse()
var complement = content.multiReplace(("A", "T"), ("T", "A"), ("G", "C"), ("C", "G"))
echo complement