import std/strutils

var dnas: seq[string] = @[]

for line in "rosalind_long.txt".readFile.strip.splitLines:
    let line2 = line.strip()
    if line2.startsWith('>'):
        dnas.add("")
    else:
        dnas[^1] &= line2

var originalReadLength = dnas[0].len

proc findSuperString(str1, str2: string): tuple[ss: string, overlap: int] =
    result.ss = ""
    result.overlap = 0

    var maxOverlap = min(str1.len, str2.len)
    var minOverlap = (originalReadLength div 2) + 1

    if str1 in str2:
        return (ss: str2, overlap: str1.len)
    elif str2 in str1:
        return (ss: str1, overlap: str2.len)

    for candidateOverlap in countdown(maxOverlap, minOverlap):
        if str1.endsWith(str2[0 ..< candidateOverlap]):
            result.ss = str1 & str2[candidateOverlap .. ^1]
            result.overlap = candidateOverlap
            break
        
        elif str2.endsWith(str1[0 ..< candidateOverlap]):
            result.ss = str2 & str1[candidateOverlap .. ^1]
            result.overlap = candidateOverlap
            break

proc findMatch(): tuple[i, j: int, ss: string, overlap: int] =
    result.ss = ""
    result.overlap = 0
    result.i = -1
    result.j = -1

    for i in 0..<dnas.len:
        for j in (i+1)..<dnas.len:
            var match = findSuperString(dnas[i], dnas[j])
            if match.overlap == 0: continue
            if match.overlap > result.overlap:
                result.i = i
                result.j = j
                result.overlap = match.overlap
                result.ss = match.ss

while true:
    var match = findMatch()
    if match.overlap == 0:
        break
    
    dnas.delete(max(match.i, match.j))
    dnas.delete(min(match.i, match.j))
    dnas.add(match.ss)

echo dnas.len
"rosalind_long_output.txt".writeFile dnas[0]