import std/strutils

var content = readFile("rosalind_rna.txt")
var transcribed = content.replace('T', 'U')

echo transcribed