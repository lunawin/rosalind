import std/strutils
import std/math

var content = "rosalind_lia.txt".readFile.strip.split
var k = content[0].parseInt
var N = content[1].parseInt

#[
(with help of gemini)
AaBb x AaBb
-> AA, Aa, aa, BB, Bb, bb

All mates are AaBb
so we just bruteforce

AA x Aa
-> AA, AA, (Aa, Aa) (%50 chance)

Aa x Aa
-> AA, (Aa, Aa), aa (%50 chance)

aa x Aa
-> (Aa, Aa), aa, aa (%50 chance)

apply same thing for B alelle
That means no matter genes of partner, since mate is AaBb
probability of AaBb child is always 50% x 50% = (%25)
]#

#[
(entirely with help of gemini, for the interpretation)

so let's say theres 8 children

and we want N = 2, meaning atleast 2 children is AaBb
then that means our probability is
(different ways of doing this) (%25)^2 * (%75)^6
(different ways of doing this) (%25)^3 * (%75)^5
(different ways of doing this) (%25)^4 * (%75)^4
(different ways of doing this) (%25)^5 * (%75)^3
(different ways of doing this) (%25)^6 * (%75)^2
(different ways of doing this) (%25)^7 * (%75)^1
(different ways of doing this) (%25)^8 * (%75)^0
]#

var probability = 0.0

proc my_binom(n: int, r: int): float =
    # nCr = n!/r!(n-r)!
    # = [ n(n-1)(n-2)(n-3)(n-4)...(n-r)...(n-n+1) ]
    #   ----------------------------
    #    (n-r)(n-r+1)(n-r+2)...(n-r+r+1)r(r-1)(r-2)(r-3)...(1)

    # = n(n-1)(n-2)(n-3)...(n-r-r+1)
    #   --------------------------
    #   r(r-1)(r-2)(r-3)...(r-r+1)

    result = 1.0
    var N = n.toFloat
    var R = r.toFloat

    for i in 0..<r:
        var i2 = i.toFloat
        result *= (N - i2)
        result /= (R - i2)

for n in N..(2^k):
    var n2 = 2^k-n
    var term = (0.25^n) * (0.75^n2)
    
    # for coefficient, we just do repeated permutation (combination btw)
    # (n+n2)!/(n!n2!)
    #var coefficient = fac(n+n2) / (fac(n) * fac(n2))
    # or so i said, but fac apparently is restricted to 128 at most
    # doesnt matter either way, i said combinations, right?
    #var coefficient = binom(n+n2, n2).toFloat
    # ...i said, but it has overflow
    # AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    var coefficient = my_binom(n+n2, n2)
    probability += coefficient * term

echo probability.formatFloat(precision=3)

# TODO: clean this code up