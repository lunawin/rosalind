import std/strutils

# https://en.wikipedia.org/wiki/Longest_common_subsequence
proc create_lcs_table(X, Y:  openarray[char]): seq[seq[int]] =
    var m = X.len
    var n = Y.len

    result = newSeq[seq[int]](m+1)
    for i in 0..<result.len:
        result[i] = newSeq[int](n+1)
    
    for i in 1..m:
        for j in 1..n:
            if X[i-1] == Y[j-1]:
                result[i][j] = result[i-1][j-1] + 1
            else:
                result[i][j] = max(result[i][j-1], result[i-1][j])

proc get_lcs_length(C: seq[seq[int]], m, n: int): int =
    return C[m][n]

proc backtrack_lcs(C: seq[seq[int]], X, Y: openarray[char], i, j: int): string =
    if i == 0 or j == 0:
        return ""
    if X[i-1] == Y[j-1]:
        return backtrack_lcs(C, X, Y, i-1, j-1) & X[i-1]
    if C[i][j-1] > C[i-1][j]:
        return backtrack_lcs(C, X, Y, i, j-1)
    else:
        return backtrack_lcs(C, X, Y, i-1, j)

###########################################
var dnas: seq[string]
for line in "rosalind_lcsq.txt".readFile.strip.splitLines:
    if line.startsWith('>'):
        dnas.add("")
    else:
        dnas[^1] &= line.strip

var X = dnas[0]
var Y = dnas[1]
var C = create_lcs_table(X, Y)
echo "Created LCS table."
echo backtrack_lcs(C, X, Y, X.len, Y.len)