import std/strutils

var dnas: seq[string]
for line in "rosalind_sseq.txt".readFile.strip.splitLines:
    if line.startsWith('>'):
        dnas.add("")
    else:
        dnas[^1] &= line.strip

var S = dnas[0]
var T = dnas[1]

proc findShortestIndices(): seq[int] =
    result.add(0)
    for i in 0..<T.len:
        var index = S.find(T[i], result[^1]+1)
        result.add(index)

var toWrite = ""
for i, item in findShortestIndices():
    if i == 0: continue
    toWrite &= $(item + 1) & " "
echo toWrite