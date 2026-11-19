import std/strutils
import std/sequtils
import std/math

let content = "rosalind_lgis.txt".readFile.strip.splitLines
let length = content[0].strip.parseInt
let permutation = content[1].strip.split(" ").mapIt(it.parseInt)

# https://en.wikipedia.org/wiki/Longest_increasing_subsequence
proc find_subsequence(increasing: static[bool]): seq[int] =
    let X = permutation
    let N = length
    var P = newSeq[int](N)
    var M = newSeq[int](N+1)

    var L = 0
    for i in 0..<N:
        var lo = 1
        var hi = L + 1

        while lo < hi:
            var mid = lo + floor((hi-lo)/2).toInt
            when increasing:
                if X[M[mid]] >= X[i]:
                    hi = mid
                else:
                    lo = mid + 1
            else:
                if X[M[mid]] <= X[i]:
                    hi = mid
                else:
                    lo = mid + 1
                
        
        var newL = lo
        P[i] = M[newL - 1]
        M[newL] = i

        if newL > L:
            L = newL

    var S = newSeq[int](L)
    var k = M[L]
    for j in countdown(L-1, 0):
        S[j] = X[k]
        k = P[k]
    return S

"rosalind_lgis_output.txt".writeFile(
    find_subsequence(true).join(" ") & 
    "\n" & 
    find_subsequence(false).join(" ")
)