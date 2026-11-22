import std/strutils
import std/algorithm

proc revc(read: string): string =
    result = read
    result.reverse()
    result = result.multiReplace(("A", "T"), ("T", "A"), ("G", "C"), ("C", "G"))

var reads: seq[string] = @[]
var correctReads: seq[string] = @[]
var wrongReads: seq[string] = @[]
for line in "rosalind_corr.txt".readFile.strip.splitLines:
    if line.startsWith('>'):
        reads.add("")
    else:
        reads[^1] &= line.strip

proc existsOtherThanIndex(a: seq[string], b: string, i: int): bool =
    if a[0 ..< i].find(b) >= 0:
        return true
    elif a[(i+1) .. ^1].find(b) >= 0:
        return true
    else:
        return false

proc hammingDistance(read1, read2: string): int =
    for i in 0..<read1.len:
        if read1[i] != read2[i]:
            result.inc

proc isCorrect(read: string, revcomp: string, index: int): bool =
    if reads.existsOtherThanIndex(read, index):
        return true
    elif reads.existsOtherThanIndex(revcomp, index):
        return true
    else:
        return false

for i, read in reads.pairs:
    var revcomp = revc(read)
    var status = isCorrect(read, revcomp, i)
    if status:
        correctReads.add(read)
        if revcomp notin correctReads:
            correctReads.add(revcomp)
    else:
        wrongReads.add(read)

proc findCorrectRead(wrongRead: string): string =
    for correct in correctReads:
        if hammingDistance(wrongRead, correct) == 1:
            return correct

var toWrite = ""
for wrong in wrongReads:
    toWrite &= wrong & "->" & findCorrectRead(wrong) & "\n"
"rosalind_corr_output.txt".writeFile toWrite